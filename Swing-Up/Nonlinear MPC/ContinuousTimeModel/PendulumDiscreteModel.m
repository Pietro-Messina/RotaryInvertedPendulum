function xk1 = PendulumDiscreteModel(xk, uk, Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2)
%% Discrete-time nonlinear dynamic model of the pendulum
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
% xk1 is the states at time k+1.
%
% Copyright 2018 The MathWorks, Inc.

% Repeat application of Euler method sampled at Ts/M.
M = 10;
delta = Ts/M;
xk1 = xk;
for ct=1:M
    xk1 = xk1 + delta*PendulumContinuousModel(xk1,uk,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2);
end
% Note that we choose the Euler method (first oder Runge-Kutta method)
% because it is more efficient for plant with non-stiff ODEs.  You can
% choose other ODE solvers such as ode23, ode45 for better accuracy or
% ode15s and ode23s for stiff ODEs.  Those solvers are available from
% MATLAB.
