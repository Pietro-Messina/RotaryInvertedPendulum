function getValidationVectors()
    gainStruct = getGains3('gains.mat','phases.mat');
    names = fieldnames(gainStruct);
    gains = (gainStruct.(names{1}));
    gainsdB = 10*log(gains);
    phases_rad = gainStruct.(names{2});
    phases = (phases_rad*180)/pi;
    amplitudes = gainStruct.(names{3});
    omegas = gainStruct.(names{4});
    
    for i = 1:length(omegas)
        figure(1)
        grid on
        semilogx(omegas(i),gainsdB(i), 'ro'); hold on;
        figure(2)
        grid on
        semilogx(omegas(i),phases(i), 'ro'); hold on;
    end
end