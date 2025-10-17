% before running this code, run MainScript.m and
% mechanical_model_sw_input.slx

% close all
% clear all
% clc

cd(fileparts(matlab.desktop.editor.getActiveFilename));
addpath(genpath('..\..\'));
rmpath(genpath('..\Cestino'));

error1 = out.ome1_sim - out.ome1_meas;
error2 = out.ome2_sim - out.ome2_meas;

mu1 = mean(error1);
mu2 = mean(error2);

var1 = var(error1);
var2 = var(error2);

covar = cov(error1, error2); %covariance matrix

subplot(2,1,1);
plot(out.ome1_meas, 'r'); hold on; plot(out.ome1_sim, 'b');
subplot(2,1,2);
plot(out.ome2_meas, 'r'); hold on; plot(out.ome2_sim, 'b');