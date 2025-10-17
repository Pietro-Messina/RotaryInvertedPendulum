% close all
% clear all
% clc

%% real tests open loop system
gainStruct = getGains3('gains.mat','phases.mat');
names = fieldnames(gainStruct);
gains = (gainStruct.(names{1}));
gainsdB = 10*log(gains);
phases_rad = gainStruct.(names{2});
phases = (phases_rad*180)/pi;
amplitudes = gainStruct.(names{3});
omegas = gainStruct.(names{4});

%% simulation open loop system
gainStruct_Sim = getGains_Sim('gains_Sim.mat','phases_Sim.mat');
names_Sim = fieldnames(gainStruct_Sim);
gains_Sim = (gainStruct_Sim.(names_Sim{1}));
gainsdB_Sim = 10*log(gains_Sim);
phases_Sim_rad = gainStruct_Sim.(names_Sim{2});
phases_Sim = (phases_Sim_rad*180)/pi;
amplitudes_Sim = gainStruct_Sim.(names_Sim{3});
omegas_Sim = gainStruct_Sim.(names_Sim{4});

%% real tests arm control + PID
gainStructPID = getGainsPID('gains_PID.mat','phases_PID.mat');
namesPID = fieldnames(gainStructPID);
gainsPID = (gainStructPID.(namesPID{1}));
gainsdBPID = 10*log(gainsPID);
phasesPID_rad = gainStructPID.(namesPID{2});
phasesPID = (phasesPID_rad*180)/pi;
amplitudesPID = gainStructPID.(namesPID{3});
omegasPID = gainStructPID.(namesPID{4});

%% simulation arm control + PID
gainStructPID_Sim = getGainsPID_Sim('gains_PID_Sim.mat','phases_PID_Sim.mat');
namesPID_Sim = fieldnames(gainStructPID_Sim);
gainsPID_Sim = (gainStructPID_Sim.(namesPID_Sim{1}));
gainsdBPID_Sim = 10*log(gainsPID_Sim);
phasesPID_Sim_rad = gainStructPID_Sim.(namesPID_Sim{2});
phasesPID_Sim = (phasesPID_Sim_rad*180)/pi;
amplitudesPID_Sim = gainStructPID_Sim.(namesPID_Sim{3});
omegasPID_Sim = gainStructPID_Sim.(namesPID_Sim{4});


% %% solo una prova per vedere se plottando i valori hanno senso:
% for i = 1:length(omegas)
%     figure(1)
%     grid on
%     semilogx(omegas(i),gainsdB(i), 'ro'); hold on;
%     figure(2)
%     grid on
%     semilogx(omegas(i),phases(i), 'ro'); hold on;
% end
% 
% % solo una prova per vedere se plottando i valori hanno senso:
% for i = 1:length(omegas_Sim)
%     figure(3)
%     grid on
%     semilogx(omegas_Sim(i),gainsdB_Sim(i), 'ro'); hold on;
%     figure(4)
%     grid on
%     semilogx(omegas_Sim(i),phases_Sim(i), 'ro'); hold on;
% end
% 
% % solo una prova per vedere se plottando i valori hanno senso:
% for i = 1:length(omegasPID)
%     figure(5)
%     grid on
%     semilogx(omegasPID(i),gainsdBPID(i), 'ro'); hold on;
%     figure(6)
%     grid on
%     semilogx(omegasPID(i),phasesPID(i), 'ro'); hold on;
% end
% 
% % solo una prova per vedere se plottando i valori hanno senso:
% for i = 1:length(omegasPID_Sim)
%     figure(7)
%     grid on
%     semilogx(omegasPID_Sim(i),gainsdBPID_Sim(i), 'ro'); hold on;
%     figure(8)
%     grid on
%     semilogx(omegasPID_Sim(i),phasesPID_Sim(i), 'ro'); hold on;
% end
