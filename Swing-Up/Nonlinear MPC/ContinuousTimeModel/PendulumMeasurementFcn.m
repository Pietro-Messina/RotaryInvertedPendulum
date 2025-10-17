function y = PendulumMeasurementFcn(x)
%% Discrete-time nonlinear dynamic model of a pendulum on a cart at time k
%
% 4 states (xk):
%   cart position (theta1)
%   cart velocity (theta1_dot): when positive, the beam moves to the right
%   angle (theta2): when 0, pendulum is at upright position
%   angular velocity (theta2_dot): when positive, pendulum moves clockwisely
% 
% 1 inputs: (uk)
%   voltage (Vin): when positive, motor pushes the beam to the right 
%
% 4 outputs: (yk)
%   same as states (i.e. all the states are measureable)
%
% xk1 is the states at time k+1.
%
% Copyright 2016 The MathWorks, Inc.

y = [x(1);x(3)];