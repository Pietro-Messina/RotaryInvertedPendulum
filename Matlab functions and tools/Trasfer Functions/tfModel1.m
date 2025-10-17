function [tf1, tf2] = tfModel1(Par)

    k1 = Par.Jeq+Par.m2*Par.l1^2;
    k2 = Par.m2*Par.l1*Par.x2;
    k3 = Par.Kf1+Par.Km^2/Par.Rm;
    k4 = Par.Km/Par.Rm;
    k5 = Par.m2*Par.l1*Par.x2;
    k6 = Par.m2*Par.x2^2+Par.I2;
    k7 = Par.Kf2;
    k8 = Par.m2*Par.g*Par.x2;

    % Input: Vin
    % Variabili di stato: [Theta1; Theta2; Omega1; Omega2]
    % Output: [Theta1; Theta2]
    
    A = [0 0 1 0;
          0 0 0 1;
          0 (k2*k8)/(k1*k6-k2*k5) -(k3*k6)/(k1*k6-k2*k5) (k2*k7)/(k1*k6-k2*k5);
          0 -(k1*k8)/(k1*k6-k2*k5) (k3*k5)/(k1*k6-k2*k5) -(k1*k7)/(k1*k6-k2*k5)];
    
    B = [0;
          0; 
          (k4*k6)/(k1*k6-k2*k5);
          -(k4*k5)/(k1*k6-k2*k5)];
    
    C = [1 0 0 0;
          0 1 0 0];
    
    D = [0;
          0];
      
    % Calcolo funzione di trasferimento
    [num, den] = ss2tf(A, B, C, D);
    tf1 = struct();
    tf2 = struct();
    tf1.num = num(1,:);
    tf1.den = den;
    tf2.num = num(2,:);
    tf2.den = den;

end