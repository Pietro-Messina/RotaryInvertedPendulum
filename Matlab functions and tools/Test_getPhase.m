clear
addpath('Data processing');
addpath('..\Tests\Test From Simulation PID');
file = load('sim_1sin(2).mat');
field_names = fieldnames(file);
data = file.(field_names{1});
omega = 2;
A = getAmplitude_Sim(file, omega);
[phi, b] = getPhase_Sim(file, A, omega);
phi_deg = phi*180/pi;

figure
hold on
grid on
time = data(1,:);
plot(time, 1*sin(2*time), 'c')
plot(time, data(2,:), 'r')
plot(time, A*sin(omega*time+phi)+b, 'b')
xline(550*0.02, 'g', 'LineWidth', 2)
% plot(time, A*sin(omega*time+phi), 'm')
legend('input', 'theta', 'fitted theta', '')
% title(sprintf('test with frequency %.1f. Expected phase: %.1f', omega, phi_deg))
title(sprintf('test with frequency %.1f. Phase: %.1f', omega, phi_deg))
