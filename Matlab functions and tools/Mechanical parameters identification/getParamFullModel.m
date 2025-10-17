function [Jeq, Kf1, Ks] = getParamFullModel(gains, Par)    
    
    %Datasheet values and guesses
    Jeq_d = Par.m1*Par.l1^2/3;  %Inertia moment of a beam from its extremity
    Kf1_g = 1e-5;               %Initial guess basing on general friction coefficients values
    Ks_g = 1e-3;                %Initial guess on spring stiffness coefficient

    %Parameter vector: w = [Jeq, Kf1, Ks]

    measures = gains.gain;
    omegas = gains.omega;

    initialGuess = [Jeq_d, Kf1_g, Ks_g];
   
    lowerBound = zeros(size(initialGuess));
    upperBound = inf*ones(size(initialGuess));
    %lowerBound = initialGuess / 2;
    %upperBound = initialGuess * 1.5;   
    
    % Non linear constraints
    problem = struct;
    problem.solver = 'lsqcurvefit';  % Solver
    problem.objective = @(w, omega) model(omega, w, Par);  % Objective function
    problem.x0 = initialGuess;  % Initial guess for parameters
    problem.xdata = omegas;  % Input data
    problem.ydata = measures;  % Output data
    problem.lb = lowerBound;  % Lower bounds
    problem.ub = upperBound;  % Upper bounds
%     problem.nonlcon = @(w) constr(w, Par);  % Nonlinear constraint
    problem.options = optimoptions(@lsqcurvefit,'Algorithm','trust-region-reflective');
    
    estParam = lsqcurvefit(problem);
    
    Jeq = estParam(1);
    Kf1 = estParam(2);
    Ks = estParam(3);
    
    %%Plot    
    figure
    fittedfunct = fittedFunction(estParam, Par);
    bodemag(fittedfunct);
    hold on
    grid on
    datasheetfunct = datasheetfunction(Jeq_d, Kf1_g, Ks_g, Par);
%     bodemag(datasheetfunct);
    
    cont_t = 1;
    cont_v = 1;
    for i = 1 : length(gains.omega)
        if gains.omega(i) == 1.7 || gains.omega(i) == 9 || gains.omega(i) == 35 || ...
                gains.omega(i) == 3.6 || gains.omega(i) == 20 || gains.omega(i) == 2.4 || ...
                gains.omega(i) == 12.5 || gains.omega(i) == 5
            val_ome(cont_v) = gains.omega(i);
            val_gains(cont_v) = gains.gain(i);
            val_phase(cont_v) = gains.phase(i);
            cont_v = cont_v + 1;
        else
            tr_ome(cont_t) = gains.omega(i);
            tr_gains(cont_t) = gains.gain(i);
            tr_phase(cont_t) = gains.phase(i);
            cont_t = cont_t + 1;
        end
    end
       
%     plot(gains.omega, 20*log10(gains.gain), 'rx', 'MarkerSize', 10);
    plot(tr_ome, 20*log10(tr_gains), 'rx', 'MarkerSize', 10);
    title('Physical model magnitude')
    grid on
    hold off
    
    figure
    bodemag(fittedfunct);
    hold on
    plot(val_ome, 20*log10(val_gains), 'rx', 'MarkerSize', 10);
    title('Physical model magnitude (Validation)')
    grid on
    hold off
    
    figure
    hold on
    grid on
    h1 = bodeplot(fittedfunct);
    setoptions(h1,'MagVisible','off');
%     h2 = bodeplot(datasheetfunct);
%     setoptions(h2,'MagVisible','off');
    plot(tr_ome, tr_phase*180/pi, 'rx', 'MarkerSize', 10);
    grid on
    title('Physical model phase')
    
    figure
    hold on
    grid on
    h1 = bodeplot(fittedfunct);
    setoptions(h1,'MagVisible','off');
%     h2 = bodeplot(datasheetfunct);
%     setoptions(h2,'MagVisible','off');
    plot(val_ome, val_phase*180/pi, 'rx', 'MarkerSize', 10);
    grid on
    title('Physical model phase (Validation)')
    
end

function y = model(omega, w, Par)

    load('Data\staticGainsVector.mat');
    

    %Parameter vector: w = [Jeq, Kf1, Ks]
    k1 = w(1)+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = w(2)+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;

    alpha = k1*k6-k2*k5;
    beta = k1*k7+k3*k6;
    gamma = k1*k8+w(3)*k6+k3*k7;
    delta = k3*k8+w(3)*k7;
    epsilon = w(3)*k8;

    y = (k4*((k8-k6*omega.^2).^2+(k7*omega).^2).^0.5)./((alpha*omega.^4-gamma*omega.^2+epsilon).^2+(-beta*omega.^3+delta*omega).^2).^0.5;

end

function func = fittedFunction(w, Par)
    %Parameter vector: w = [Jeq, Kf1, Ks]   
    k1 = w(1)+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = w(2)+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;

    alpha = k1*k6-k2*k5;
    beta = k1*k7+k3*k6;
    gamma = k1*k8+w(3)*k6+k3*k7;
    delta = k3*k8+w(3)*k7;
    epsilon = w(3)*k8;

    func = tf([k4*k6 k4*k7 k4*k8], [alpha beta gamma delta epsilon]);
end

function func = datasheetfunction(Jeq_d, Kf1_g, Ks_g , Par)
    k1 = Jeq_d+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = Kf1_g+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;
    

    alpha = k1*k6-k2*k5;
    beta = k1*k7+k3*k6;
    gamma = k1*k8+Ks_g*k6+k3*k7;
    delta = k3*k8+Ks_g*k7;
    epsilon = Ks_g*k8;

    func = tf([k4*k6 k4*k7 k4*k8], [alpha beta gamma delta epsilon]);
end

function [c,ceq] = constr(w, Par)
    %Parameter vector: w = [Jeq, Kf1, Ks]   
    k1 = w(1)+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = w(2)+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;

    alpha = k1*k6-k2*k5;
    beta = k1*k7+k3*k6;
    gamma = k1*k8+w(3)*k6+k3*k7;
    delta = k3*k8+w(3)*k7;
    epsilon = w(3)*k8;
    
    ceq = sqrt(k8/k6)-13;
    c = [];
end