function dx = PendulumStateFcn(x, u)
%% Discrete-time nonlinear dynamic model of a pendulum on a cart at time k
%
% 4 states (xk): 
%   cart position (theta1)
%   cart velocity (theta1_dot): when positive, the beam moves to the right
%   angle (theta2): when 0, pendulum is at upright position
%   angular velocity (theta2_dot): when positive, pendulum moves clockwisely
% 
% 1 inputs: (u)
%   voltage (Vin): when positive, motor pushes the beam to the right
%
% 4 outputs: (yk)
%   same as states (i.e. all the states are measureable)
%
% xk1 is the states at time k+1.
%
% Copyright 2016 The MathWorks, Inc.

Vin = u(1);
bm = u(2);
g = u(3);
I2 = u(4);
Jeq = u(5);
Jm = u(6);
Kf1 = u(7);
Kf2 = u(8);
Km = u(9);
Ks = u(10);
l1 = u(11);
l2 = u(12);
m1 = u(13);
m2 = u(14);
Rm = u(15);
x1 = u(16);
x2 = u(17);

dx = PendulumContinuousModel(x,Vin,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2);
