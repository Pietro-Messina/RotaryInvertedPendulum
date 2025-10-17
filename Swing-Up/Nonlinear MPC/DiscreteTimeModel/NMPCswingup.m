%% Preliminary operations
clear all
close all
clc

cd(fileparts(matlab.desktop.editor.getActiveFilename));
addpath(genpath('..\..\..\'));
rmpath(genpath('..\..\..\Cestino'));
rmpath(genpath('..\ContinuousTimeModel'));

matlabSim = false;
simulinkSim = true;
simulinkExp = false;

%% Create Nonlinear MPC Controller
nx = 4;
ny = 2;
nu = 1;
nlobj = nlmpc(nx, ny, nu);

%% NMPC parameters
load('NonLinearParameters.mat')
NonLinearParameters = orderfields(NonLinearParameters);
fieldNames = fieldnames(NonLinearParameters);

for i = 1:numel(fieldNames)
    fieldName = fieldNames{i}; % Get the name of the current field
    value = NonLinearParameters.(fieldName); % Get the value of the field
    eval([fieldName, ' = value;']);
end
clear fieldNames fieldName i value
Parameters = [bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2];

Ts = 0.1;
nlobj.Ts = Ts;
nlobj.PredictionHorizon = 6;
nlobj.ControlHorizon = 5;

% Working: 6 5

%% Specify Nonlinear Plant Model
nlobj.Model.StateFcn = @(x,u,Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2) PendulumDiscreteModel(x,u,Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2);
nlobj.Model.IsContinuousTime = false;
nlobj.Model.NumberOfParameters = 17;

nlobj.Model.OutputFcn = 'PendulumOutputFcn';
nlobj.Jacobian.OutputFcn = @(x,u,Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2) [1 0 0 0; 0 0 1 0];

%% Define Cost and Constraints
nlobj.Weights.OutputVariables = [3 4];
nlobj.Weights.ManipulatedVariablesRate = 0.6;

%Working: [3 3], 0.5 slow, 5s
%Working: [3 5], 0.3 fast, 2s, slightly out of bound theta1


% The beam angle is limited to the range |-2| to |2|.
nlobj.OV(1).Min = -2;
nlobj.OV(1).Max = 2;

% The input voltge has a range between |-10| and |10|.
nlobj.MV.Min = -10;
nlobj.MV.Max = 10;

%% Validate Nonlinear MPC Controller
xVal = [0.1;0.2;-pi/2;0.3];
uVal = 0.4;
validateFcns(nlobj,xVal,uVal,[],{Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2});

%% State Estimation
EKF = extendedKalmanFilter(@PendulumStateFcn, @PendulumMeasurementFcn);

%% Initialization
% Specify the initial conditions for simulations by setting the initial
% plant state and output values. Also, specify the initial state of the
% extended Kalman filter.
x0 = [0;0;0;0];

% |mv| is the optimal control move computed at any control interval.
% Initialize |mv| to zero, since the force applied to the cart is zero at
% the beginning.
mv = 0;

% In the first stage of the simulation, the pendulum swings up from a
% downward equilibrium position to an inverted equilibrium position. The
% state references for this stage are all zero.
yref = [1.5 pi];

Duration = 15;

%% Closed-Loop Simulation in MATLAB(R)
if matlabSim    
    x = x0;
    y = [x(1);x(3)];
    EKF.State = x;    
    
    % Using the <docid:mpc_ref#mw_953dc5ee-1b69-4a61-92d3-b6ae8a304f74>
    % command, compute optimal control moves at each control interval. This
    % function constructs a nonlinear programming problem and solves it using
    % the |fmincon| function from the Optimization Toolbox.
    %
    % Specify the prediction model parameter using an
    % <docid:mpc_ref#mw_346dc978-860c-4a9a-a25a-591184c50b61> object, and pass
    % this object to |nlmpcmove|.
    nloptions = nlmpcmoveopt;
    nloptions.Parameters = {Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2};

    % Run the simulation for |20| seconds.
    hbar = waitbar(0,'Simulation Progress');
    xHistory = x;
    mvHistory = mv;
    for ct = 1:(Duration/Ts)
        % Correct previous prediction using current measurement.
        xk = correct(EKF, y);

        % Compute optimal control moves.
        [mv,nloptions,info] = nlmpcmove(nlobj,xk,mv,yref,[],nloptions);

        % Predict prediction model states for the next iteration.
        predict(EKF, [mv; Ts; bm;g;I2;Jeq;Jm;Kf1;Kf2;Km;Ks;l1;l2;m1;m2;Rm;x1;x2]);

        % Implement first optimal control move and update plant states.
        x = PendulumDiscreteModel(x,mv,Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2);

        % Generate sensor data with some white noise.
        y = x([1 3]) + randn(2,1)*0.01; 

        % Save plant states for display.
        mvHistory = [mvHistory mv];
        xHistory = [xHistory x]; %#ok<*AGROW>
        waitbar(ct*Ts/20,hbar);
    end
    close(hbar)

    % Plot the closed-loop response.
    figure
    
    plot(0:Ts:Duration,mvHistory)
    xlabel('time')
    ylabel('Vin')
    title('Vin')

    figure

    subplot(2,2,1)
    plot(0:Ts:Duration,xHistory(1,:))
    xlabel('time')
    ylabel('z')
    title('Theta1')

    subplot(2,2,2)
    plot(0:Ts:Duration,xHistory(2,:))
    xlabel('time')
    ylabel('zdot')
    title('Theta1 dot')

    subplot(2,2,3)
    plot(0:Ts:Duration,xHistory(3,:))
    xlabel('time')
    ylabel('theta')
    title('Theta2')

    subplot(2,2,4)
    plot(0:Ts:Duration,xHistory(4,:))
    xlabel('time')
    ylabel('thetadot')
    title('Theta2 dot')
end

%% Closed-Loop Simulation in Simulink
if simulinkSim
    % Validate the nonlinear MPC controller with a closed-loop simulation in
    % Simulink.
    %
    % Open the Simulink model.
    mdlSim = 'NMPCsim';
    open_system(mdlSim)

    % To use optional parameters in the prediction model, the model has a
    % Simulink Bus block connected to the |params| input port of the Nonlinear
    % MPC Controller block. To configure this bus block to use the |Ts|
    % parameter, create a Bus object in the MATLAB workspace and configure
    % the Bus Creator block to use this object. To do so, use the
    % <docid:mpc_ref#mw_8f9e5d62-cfe1-499a-9420-e5099dedfe76> function. In this
    % example, name the Bus object |'myBusObject'|.
    % createParameterBus(nlobj,[mdl '/NMPC Controller'],'myBusObject',{'Ts','bm','g','I2','Jeq','Jm','Kf1','Kf2','Km','Ks','l1','l2','m1','m2','Rm','x1','x2'});
    createBusObj();
end
    
%% Real case scenario
if simulinkExp
    % Open the experimental file
    mdlExp = 'NMPCexp';
    open_system(mdlExp)
    
    %Create bus object
    createBusObj();
end