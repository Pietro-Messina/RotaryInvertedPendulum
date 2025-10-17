function [Km, Rm, Jm, bm] = getParamMotorKmRm(gains, stepAmplitude)
    
    Jm = 4.6e-6;
    bm_ds = 0;

    A = mean([stepAmplitude.ampl1 stepAmplitude.ampl2]);

    %% Fit the model
    % Datasheet values
    Rm_ds = 8.4;
    Km_ds = 0.042;

    % Parameters vector: w = [Rm, km, Jm]
    model = @(w, omega) w(2)./((w(1)*((w(2)-A*w(2).^2)/(A*w(1)))+w(2).^2).^2*omega.^2+(w(1)*Jm*omega.^2).^2).^0.5;
    
    omegas = gains.omega;
    measures = gains.gain;
    
    initialGuess = [Rm_ds, Km_ds];%, Jm];
    
    
    % Set optimization options
%     options = optimoptions('lsqcurvefit', 'Display', 'iter', 'MaxFunctionEvaluations', 1e4);
    options = optimoptions('lsqcurvefit', 'MaxFunctionEvaluations', 1e4);
    
    lowerBound = zeros(size(initialGuess));
    upperBound = inf*ones(size(initialGuess));
    lowerBound(1) = initialGuess(1)/2;
    upperBound(1) = initialGuess(1)*1.5;
    upperBound(2) = 1/A;
    
    
    % Perform optimization
    estParam = lsqcurvefit(model, initialGuess, omegas, measures, lowerBound, upperBound, options);
    
    Rm = estParam(1);
    Km = estParam(2);
    %Jm = estParam(3);
    bm = (Km-A*(Km.^2))/(A*Rm);

    %% Plot
    fittedfunct = tf(Km, [Rm*Jm Rm*bm+Km^2 0]);
    bodemag(fittedfunct);
    hold on
    grid on
    datasheetfunct = tf(0.042, [Rm_ds*Jm Rm_ds*bm_ds+0.042^2 0]);
    bodemag(datasheetfunct);
    plot(gains.omega, 20*log10(gains.gain), 'rx', 'MarkerSize', 10);
    title('Motor transfer functions')
    hold off
end
