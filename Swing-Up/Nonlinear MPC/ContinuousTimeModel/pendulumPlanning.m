function pendulumPlanning(Info)
% FlyingRobotPlotPlanning displays the optimal trajectory of the flying
% robot.

% Copyright 2018 The MathWorks, Inc.

Xopt = Info.Xopt;
MVopt = Info.MVopt;

%% Examine solution
t = Info.Topt;
figure(1)
states = {'theta1','theta1 dot','theta2','theta2 dot'};
for i = 1:size(Xopt,2)
    subplot(2,2,i)
    plot(t,Xopt(:,i),'o-')
    title(states{i})
end

figure(2)
plot(t,MVopt)
title('Vin')
