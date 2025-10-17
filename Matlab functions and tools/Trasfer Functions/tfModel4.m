function tf1 = tfModel4(Par)

    k1 = Par.Jeq+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = Par.Kf1+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;

    % Input: Vin
    % Variabili di stato: [Theta1; Omega1]
    % Output: Theta1
    
    A = [-Par.Ks/k1 -k3/k1;
          0 1];
    
    B = [k4/k1;
          0];
    
    C = [1 0];
    
    D = 0;
    
    % Calcolo funzione di trasferimento
    [num, den] = ss2tf(A, B, C, D);
    tf1 = struct();
    tf1.num = num(1,:);
    tf1.den = den;

end