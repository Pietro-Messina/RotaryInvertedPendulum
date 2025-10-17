function [Jeq, Ks] = getParamFullModelJeqKs(gains, Par)    
    
    %Datasheet values and guesses
    Jeq_d = Par.m1*Par.l1^2/3 ;  %Inertia moment of a beam from its extremity
    Ks_g = 7e-3;                %Initial guess on spring stiffness coefficient

    %Parameter vector: w = [Jeq, Ks]

    measures = gains.gain;
    omegas = gains.omega;

    initialGuess = [Jeq_d, Ks_g];
   
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
    Ks = estParam(2);
    
    %%Plot    
    figure
    fittedfunct = fittedFunction(estParam, Par);
    bodemag(fittedfunct);
    hold on
    grid on
%     datasheetfunct = datasheetfunction(Jeq_d, Ks_g, Par);
%     bodemag(datasheetfunct);
    plot(gains.omega, 20*log10(gains.gain), 'rx', 'MarkerSize', 10);
    title('Physical model transfer functions')
    hold off
    
    figure
    hold on
    grid on
    h1 = bodeplot(fittedfunct);
    setoptions(h1,'MagVisible','off');
%     h2 = bodeplot(datasheetfunct);
%     setoptions(h2,'MagVisible','off');
    plot(gains.omega, gains.phase*180/pi, 'rx', 'MarkerSize', 10);
    
end

function y = model(omega, w, Par)
    %Parameter vector: w = [Jeq, Ks]
    k1 = w(1)+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = Par.Kf1+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;

    alpha = k1*k6-k2*k5;
    beta = k1*k7+k3*k6;
    gamma = k1*k8+w(2)*k6+k3*k7;
    delta = k3*k8+w(2)*k7;
    epsilon = w(2)*k8;

    y = (k4*((k8-k6*omega.^2).^2+(k7*omega).^2).^0.5)./((alpha*omega.^4-gamma*omega.^2+epsilon).^2+(-beta*omega.^3+delta*omega).^2).^0.5;

end

function func = fittedFunction(w, Par)
     %Parameter vector: w = [Jeq, Ks]
    k1 = w(1)+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = Par.Kf1+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;

    alpha = k1*k6-k2*k5;
    beta = k1*k7+k3*k6;
    gamma = k1*k8+w(2)*k6+k3*k7;
    delta = k3*k8+w(2)*k7;
    epsilon = w(2)*k8;

    func = tf([k4*k6 k4*k7 k4*k8], [alpha beta gamma delta epsilon]);
end

% function func = datasheetfunction(Jeq_d, Ks_g , Par)
%       %Parameter vector: w = [Jeq, Ks]
%     k1 = w(1)+Par.m2*Par.l1^2;
%     k2 = Par.m2*Par.l1*Par.x2;
%     k3 = Par.Kf1+Par.Km^2/Par.Rm;
%     k4 = Par.Km/Par.Rm;
%     k5 = Par.m2*Par.l1*Par.x2;
%     k6 = Par.m2*Par.x2^2+Par.I2;
%     k7 = Par.Kf2;
%     k8 = Par.m2*Par.g*Par.x2;
% 
%     alpha = k1*k6-k2*k5;
%     beta = k1*k7+k3*k6;
%     gamma = k1*k8+w(2)*k6+k3*k7;
%     delta = k3*k8+w(2)*k7;
%     epsilon = w(2)*k8;
% 
%     func = tf([k4*k6 k4*k7 k4*k8], [alpha beta gamma delta epsilon]);
% end

% function [c,ceq] = constr(w, Par)
%     %Parameter vector: w = [Jeq, Kf1, Ks]   
%     k1 = w(1)+Par.m2*Par.l1^2;
%     k2 = Par.m2*Par.l1*Par.x2;
%     k3 = w(2)+Par.Km^2/Par.Rm;
%     k4 = Par.Km/Par.Rm;
%     k5 = Par.m2*Par.l1*Par.x2;
%     k6 = Par.m2*Par.x2^2+Par.I2;
%     k7 = Par.Kf2;
%     k8 = Par.m2*Par.g*Par.x2;
% 
%     alpha = k1*k6-k2*k5;
%     beta = k1*k7+k3*k6;
%     gamma = k1*k8+w(3)*k6+k3*k7;
%     delta = k3*k8+w(3)*k7;
%     epsilon = w(3)*k8;
%     
%     ceq = sqrt(k8/k6)-13;
%     c = [];
% end