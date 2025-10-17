function [phi, b] = getPhase_Sim(file, A, omega)

    names = fieldnames(file);
    data = file.(names{1});
    values = data(2,550:length(data)-20);
    time = data(1,550:length(data)-20);
      
    % Define fit function
    sinusoid = @(w, t) A*sin(omega*t+w(1))+w(2);
        
    % Fit
    estParam = lsqcurvefit(sinusoid, [0 0], time, values);
    
    % Extract parameters
    phi = estParam(1);
    b = estParam(2);    
end