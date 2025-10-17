file = load('pendolo_alessandro/data_05-Apr-2024_11-04-21.mat');
    
names = fieldnames(file);
data = file.(names{1});
pos_theta1 = data(2,:) * 2 * pi / 2048;
pos_theta2 = - data(3,:) * 2 * pi / 2048;
T = data(1,:);

%plot
figure;
plot(T, pos_theta1, 'y');
hold on;
plot(T, pos_theta2, 'b');
xlabel('Time');
ylabel('Signal');
title('Risposta del sistema reale');
legend('theta1', 'theta2');
grid on;
hold off;