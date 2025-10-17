function dxdt = PendulumContinuousModel(x, u, bm,g,I2,Jeq,Jm,Kf1,Kf2,Km,Ks,l1,l2,m1,m2,Rm,x1,x2)

%% Continuous-time nonlinear dynamic model of a pendulum
%
% 4 states (x): 
%   cart position (theta1)
%   cart velocity (theta1_dot): when positive, the beam moves to the right
%   angle (theta2): when 0, pendulum is at upright position
%   angular velocity (theta2_dot): when positive, pendulum moves clockwisely
% 
% 1 inputs: (u)
%   voltage (Vin): when positive, motor pushes the beam to the right
%
% Copyright 2018 The MathWorks, Inc.

%% Obtain x, u and y
% x
theta1 = x(1);
theta1_dot = x(2);
theta2 = x(3);
theta2_dot = x(4);

% u
Vin = u;

%% Compute dxdt
k1 = Jeq + m2*(l1^2 + x2^2*sin(theta2)^2);
k2 = m2*l1*x2*cos(theta2);
k3 = 2*m2*x2^2*sin(theta2)*cos(theta2)*theta1_dot*theta2_dot - m2*l1*x2*sin(theta2)*theta2_dot^2 +Ks*theta1 - Km/Rm*Vin + (Km^2)/Rm*theta1_dot + Kf1*theta1_dot;
k4 = m2*l1*x2*cos(theta2);
k5 = m2*x2^2 + I2;
k6 = - m2*x2^2*sin(theta2)*cos(theta2)*theta1_dot^2 + m2*g*x2*sin(theta2) + Kf2*theta2_dot;

dxdt = [theta1_dot;
        (k2*k6 - k3*k5)/(k1*k5 - k2*k4);
        theta2_dot;
        -(k1*k6 - k3*k4)/(k1*k5 - k2*k4)];
end 