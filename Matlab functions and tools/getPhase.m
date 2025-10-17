% -------------------------------------------------------------------------
% Phase estimation from an experiment file
% -------------------------------------------------------------------------
% Estimates the phase of theta1 from experimental data by fitting it to a 
% sinusoid and getting its missing parameters
% 
% inputs: loaded file, its amplitude and frequency
% output: phase of the sinusoid


function [phi, b] = getPhase(file, A, omega)

    names = fieldnames(file);
    data = file.(names{1});
    values = data(2,5500:length(data)-200) * 2 * pi / 2048;
    time = data(1,5500:length(data)-200);
      
    % Define fit function
    sinusoid = @(w, t) A*sin(omega*t+w(1))+w(2);
        
    % Fit
    estParam = lsqcurvefit(sinusoid, [0 0], time, values);
    
    % Extract parameters
    phi = estParam(1);
    b = estParam(2);
    
end
