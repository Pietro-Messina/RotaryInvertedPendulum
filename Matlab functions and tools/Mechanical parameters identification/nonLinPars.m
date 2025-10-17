% -------------------------------------------------------------------------
%                   Nonlinear parameters fitting
% -------------------------------------------------------------------------
% 
% This function takes as input the already evaluated model parameters and
% outputs the missing ones, using a time-response validation over the
% selected experiments.
% Place the experiment files you want to be used in the
% Tests\Selected Model Identification Tests
% folder, as all the suitable data will be selected from there

function [Jeq, Kf1, Ks] = nonLinPars(Pars)

    %% Load tests
    sampleFilter = 1; % Select one sample each 10, to reduce computational load
    Pars.res = 0.002;

    sinDataFiles = dir(fullfile('..\Tests\Selected Model Identification Tests', 'TestTOT*sin*.mat'));
    for sinTestInd=1:length(sinDataFiles)
        sinFileData = load(sinDataFiles(sinTestInd).name);
        sinFieldName = fieldnames(sinFileData);
        [~, fileName, ~] = fileparts(sinDataFiles(sinTestInd).name);
        validFieldName = regexprep(fileName, '[()]', '_'); 
        validFieldName = regexprep(validFieldName, '\.', 'x'); 
        validFieldName = regexprep(validFieldName, 'sin', '_sin');
        data = sinFileData.(sinFieldName{1});

        parts = split(validFieldName, '_');
        voltage = strrep(parts{2}, 'x', '.');
        voltage = str2double(voltage);
        frequency = strrep(parts{4}, 'x', '.');
        frequency = str2double(frequency);

        timestamps = data(1,:);
        encod1 = data(2,:) * 2 * pi / 2048;
        encod2 = data(3,:) * 2 * pi / 2048;
        input = voltage*sin(frequency*timestamps);  

        validTimeSamples = 1:sampleFilter:length(data);
        encod1 = encod1(validTimeSamples)/voltage;
        timestamps = timestamps(validTimeSamples);
        input = input(validTimeSamples)/voltage;

        sinTests{sinTestInd} = struct('timestamps', timestamps, 'encod1', encod1, 'encod2', encod2, ...
            'validFieldName', validFieldName, 'input', input);
    end

    stepDataFiles = dir(fullfile('..\Tests\Selected Model Identification Tests', 'TestTOT*sca*.mat'));
    for stepTestInd=1:length(stepDataFiles)
        stepFileData = load(stepDataFiles(stepTestInd).name);
        stepFieldName = fieldnames(stepFileData);
        data = stepFileData.(stepFieldName{1});
        [~, fileName, ~] = fileparts(stepDataFiles(stepTestInd).name);
        matches = regexp(fileName, '\d+\.\d+', 'match');
        amplitude = str2double(matches{1});

        timestamps = data(1,:);
        encod1 = data(2,:) * 2 * pi / 2048;
        encod2 = data(3,:) * 2 * pi / 2048;
        input = data(4,:);

        validTimeSamples = 1:sampleFilter:length(data);
        encod1 = encod1(validTimeSamples)/amplitude;
        encod2 = encod2(validTimeSamples)/amplitude;
        timestamps = timestamps(validTimeSamples);
        input = input(validTimeSamples)/amplitude;

        stepTests{stepTestInd} = struct('timestamps', timestamps, 'encod1', encod1, 'encod2', encod2, ...
            'validFieldName', fileName, 'input', input);
    end

    %% Experiments composition
    %Datasheet values and guesses
    Jeq_d = Pars.m1*Pars.l1^2/3;  %Inertia moment of a beam from its extremity
    Kf1_g = 1e-5;               %Initial guess basing on general friction coefficients values
    Ks_g = 1e-3;                %Initial guess on spring stiffness coefficient
    initialGuess = [Jeq_d, Kf1_g, Ks_g];

    %Select and concatenate tests
    selSinTests = 1:length(sinDataFiles);
    selStepTests = 1:length(stepDataFiles);
    input = [];
    xdata = [];
    ydata = [];

    for test_ind = selSinTests
        input = [input sinTests{test_ind}.input];
        xdata = [xdata sinTests{test_ind}.timestamps];
        ydata = [ydata sinTests{test_ind}.encod1];
    end

    for test_ind = selStepTests
        input = [input stepTests{test_ind}.input];
        xdata = [xdata stepTests{test_ind}.timestamps];
        ydata = [ydata stepTests{test_ind}.encod1];
    end

    testsLength = length(input);
    
    %% Optimization
    lb = zeros(size(initialGuess));
    ub = inf*ones(size(initialGuess));
    estParam = lsqcurvefit(@(w, t) simOutput(w, t, Pars, input), initialGuess, ...
        xdata, ydata, lb, ub);

    Jeq = estParam(1);
    Kf1 = estParam(2);
    Ks = estParam(3);

    %% Plot the experiment and the simulation
    figure
    tiledlayout(3,1)
    ax1 = nexttile;
    plot(1:testsLength, input)
    title('Input values')
    ax2 = nexttile;
    hold on
    grid on
    plot(1:testsLength, ydata)
    plot(1:testsLength, simOutput(initialGuess, xdata, Pars, input))
    title('Real output vs simulation, datasheet values')
    ax3 = nexttile;
    hold on
    grid on
    plot(1:testsLength, ydata)
    plot(1:testsLength, simOutput(estParam, xdata, Pars, input))
    title('Real output vs simulation, fitted values')
    linkaxes([ax1 ax2 ax3],'x');

end

function y = simOutput(w, t_array, Pars, Vin)
    % w = [Jeq, Kf1, Ks]
%     global theta1_dot_dot
%     global theta2_dot_dot
%     global theta1_dot
%     global theta2_dot
%     global theta1
%     global theta2
    y=[];
    for ind = 1:length(t_array)
        t = t_array(ind);
        Vin_t = Vin(ind); %Vin at time t        
        if t == 0
            theta1 = 0;
            theta2 = 0;
            theta1_dot = 0;
            theta2_dot = 0;
            [theta1_dot_dot,theta2_dot_dot] = nonLinearModel(theta1, theta2, theta1_dot, theta2_dot, Vin_t, Pars, w);
        else
            theta1_dot = theta1_dot_dot.*Pars.res+theta1_dot;
            theta2_dot = theta2_dot_dot.*Pars.res+theta2_dot;
            theta1 = theta1_dot.*Pars.res+theta1;
            theta2 = theta2_dot.*Pars.res+theta2;
            [theta1_dot_dot,theta2_dot_dot] = nonLinearModel(theta1, theta2, theta1_dot, theta2_dot, Vin_t, Pars, w);
        end

        y = [y theta1];
    end
end

function [theta1_dot_dot,theta2_dot_dot] = nonLinearModel(theta1, theta2, theta1_dot, ...
    theta2_dot, Vin, Pars, w)
    k1 = w(1,1) + Pars.m2.*(Pars.l1.^2 + Pars.x2.^2.*sin(theta2).^2);
    k2 = Pars.m2.*Pars.l1.*Pars.x2.*cos(theta2);
    k3 = 2.*Pars.m2.*Pars.x2.^2.*sin(theta2).*cos(theta2).*theta1_dot.*theta2_dot - ...
        Pars.m2.*Pars.l1.*Pars.x2.*sin(theta2).*theta2_dot.^2 + w(1,3).*theta1 - ...
        Pars.Km./Pars.Rm.*Vin + (Pars.Km.^2)./Pars.Rm.*theta1_dot + w(1,2).*theta1_dot;
    k4 = Pars.m2.*Pars.l1.*Pars.x2.*cos(theta2);
    k5 = Pars.m2.*Pars.x2.^2 + Pars.I2;
    k6 = - Pars.m2.*Pars.x2.^2.*sin(theta2).*cos(theta2).*theta1_dot.^2 + ...
        Pars.m2.*Pars.g.*Pars.x2.*sin(theta2) + Pars.Kf2.*theta2_dot;

    theta1_dot_dot = (k2.*k6 - k3.*k5)./(k1.*k5 - k2.*k4);
    theta2_dot_dot = -(k1.*k6 - k3.*k4)./(k1.*k5 - k2.*k4);
end