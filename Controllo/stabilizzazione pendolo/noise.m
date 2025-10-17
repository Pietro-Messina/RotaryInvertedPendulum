%% run this section before file simulink execution

% close all
% clear all
% clc

cd(fileparts(matlab.desktop.editor.getActiveFilename));
addpath(genpath('..\..\'));
rmpath(genpath('..\Cestino'));

load('NonLinearParameters.mat')
Parameters = NonLinearParameters;
[tf2_1,tf2_2, Adown, Bdown, Cdown] = tfModel2(Parameters); 
[tsVstep, amplVstep, stopTime] = stepFileToTS('TestTOT_1.0sca_STATGAIN.mat');



%% run this section for square wave

file = load('sw_1V1Hz.mat');
names = fieldnames(file);
data = file.(names{1}); 
% data = data(:,5/.002+1:length(data));

time = data(1,:);
input = data(2,:);
encod1_meas = data(3,:) * 2 * pi / 2048;
encod2_meas = data(4,:) * 2 * pi / 2048;

in = timeseries(input, time);
in.TimeInfo.Units = 'seconds';


%% run this section after file simulink execution

file = load('TestTOT_1.2Sca.mat');
names = fieldnames(file);
data = file.(names{1}); 

time = data(1,:);
input = out.inStep;
% encod1_meas = data(2,:) * 2 * pi / 2048;
% encod2_meas = data(3,:) * 2 * pi / 2048;


in = timeseries(input, time);
in.TimeInfo.Units = 'seconds';

encod1_sim = out.ome1_sim';
encod2_sim = out.ome2_sim';

subplot(2,1,1);
plot(encod1_meas, 'r'); hold on; plot(encod1_sim, 'b');
subplot(2,1,2);
plot(encod2_meas, 'r'); hold on; plot(-encod2_sim, 'b');

error1 = encod1_sim - encod1_meas;
error2 = encod2_sim - encod2_meas;

mu1 = mean(error1);
mu2 = mean(error2);

var1 = var(error1);
var2 = var(error2);

cov = cov(error1, error2); %covariance matrix



