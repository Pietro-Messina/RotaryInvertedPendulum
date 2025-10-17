function xk1 = PendulumStateFcn(xk, u)
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

uk = u(1);
Ts = u(2);
bm = u(3);
g = u(4);
I2 = u(5);
Jeq = u(6);
Jm = u(7);
Kf1 = u(8);
Kf2 = u(9);
Km = u(10);
Ks = u(11);
l1 = u(12);
l2 = u(13);
m1 = u(14);
m2 = u(15);
Rm = u(16);
x1 = u(17);
x2 = u(18);

xk1 = PendulumDiscreteModel(xk,uk,Ts,bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2);
