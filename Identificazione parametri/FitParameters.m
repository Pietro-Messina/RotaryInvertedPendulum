%% Preliminary operations

cd(fileparts(matlab.desktop.editor.getActiveFilename));
addpath(genpath('..\'));
rmpath(genpath('..\Cestino'));

gainsDir = 'Data processing\gains.mat';
phasesDir = 'Data processing\phases.mat';
stepAmpl = load('Data processing\step_ampl.mat');

%% Parameters evaluation
m1 = 0.095;
l1 = 0.085;
m2 = 0.024;
l2 = 0.129;
I2 = m2*l2^2/12;
% Kf2 = 7.823419745535644e-06; %decremento logaritmico
Kf2 = 8.2e-6;
g = 9.81;
x1 = l1/2;
x2 = l2/2;

[Km, Rm, Jm, bm] = getParamMotor(getGains0(gainsDir), stepAmpl);
Parameters = struct('m1', m1, 'l1', l1, 'm2', m2, 'l2', l2, 'I2', I2, 'Kf2', Kf2, 'g', g, 'Km', Km, 'Rm', Rm, 'Jm', Jm, 'bm', bm, 'x1', x1, 'x2', x2);

%Standard script, no constraints on the static gain
%[Jeq, Kf1, Ks] = getParamFullModel(getGains3(gainsDir, phasesDir), Parameters);

%The static gains are added as fitting points at the frequency of 10^-10 
% [Jeq, Kf1, Ks] = getParamFullModel(getGains3sg(gainsDir, phasesDir), Parameters);

%The mean of the static gains is imposed as a hard constraint on the system (Suggested)
[Jeq, Kf1, Ks] = getParamFullModelStaticGain(getGains3(gainsDir, phasesDir), Parameters);

LinearParameters = Parameters;
LinearParameters.Jeq = Jeq;
LinearParameters.Kf1 = Kf1;
LinearParameters.Ks = Ks;

%Nonlinear optimization
[Jeq, Kf1, Ks] = nonLinPars(Parameters);

NonLinearParameters = Parameters;
NonLinearParameters.Jeq = Jeq;
NonLinearParameters.Kf1 = Kf1;
NonLinearParameters.Ks = Ks;

%save('LinearParameters.mat', 'LinearParameters');
%save('NonLinearParameters.mat', 'NonLinearParameters');

%fprintf('Parmeters saved succesfully')