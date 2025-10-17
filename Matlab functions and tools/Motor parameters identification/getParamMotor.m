function [Km, Rm, Jm, bm] = getParamMotor(gains, stepAmplitude)
    %% Solve step data for K
    syms Km real
    stepAmpl = mean([stepAmplitude.ampl1 stepAmplitude.ampl2]);
    eq = Km/(Km^2)-stepAmpl;
    sol = solve(eq == 0, Km);
    Km = double(vpa(sol));
         
    %% Fit the model
    % Datasheet values
    Rm_ds = 8.4;
    Jm_ds = 4.6e-6;
    bm_ds = 0;

    % Parameters vector: w = [Rm, Jm, bm]
    model = @(w, omega) Km./(((w(1)*w(3)+Km^2)*omega).^2+(w(1)*w(2)*omega.^2).^2).^0.5;
    
    omegas = gains.omega;
    measures = gains.gain;
    
    initialGuess = [Rm_ds, Jm_ds, bm_ds];
    
    % Set optimization options
%     options = optimoptions('lsqcurvefit', 'Display', 'iter', 'MaxFunctionEvaluations', 1e4);
    options = optimoptions('lsqcurvefit', 'MaxFunctionEvaluations', 1e4);
    
    lowerBound = zeros(size(initialGuess));
    upperBound = inf*ones(size(initialGuess));
    lowerBound(1) = initialGuess(1)/2;
    upperBound(1) = initialGuess(1)*1.5;
    
    
    
    % Perform optimization
    estParam = lsqcurvefit(model, initialGuess, omegas, measures, lowerBound, upperBound, options);
    
    Rm = estParam(1);
    Jm = estParam(2);
    bm = estParam(3);

    %% Plot
    figure
    fittedfunct = tf(Km, [Rm*Jm Rm*bm+Km^2 0]);
    bodemag(fittedfunct);
    hold on
    grid on
    datasheetfunct = tf(0.042, [Rm_ds*Jm_ds Rm_ds*bm_ds+0.042^2 0]);
    plot(gains.omega, 20*log10(gains.gain), 'rx', 'MarkerSize', 10);
    title('Motor magnitude')
    hold off
end
