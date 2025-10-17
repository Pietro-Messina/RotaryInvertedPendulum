% function [acc1, acc2] = getAccuracy(simulink)
    
    simulink = 'mechanical_model_sw_input.slx';
    simOut = sim(simulink);

    ome1_sim  = reshape(out.ome1_sim.Data, [], 1);   
    ome1_meas = reshape(out.ome1_meas.Data, [], 1);  
    ome2_sim  = reshape(out.ome2_sim.Data, [], 1);   
    ome2_meas = reshape(out.ome2_meas.Data, [], 1);  

%   relError1 = abs((ome1_est_data - ome1_real_data) ./ ome1_real_data) * 100;
%   accuracy1 = 100 - mean(relError1(2:end));
% 
%   relError2 = abs((ome2_est_data - ome2_real_data) ./ ome2_real_data) * 100;
%   accuracy2 = 100 - mean(relError2(2:end));

    acc1 = 1 - mean(abs(ome1_sim - ome1_meas)) / mean(abs(ome1_meas));
    acc2 = 1 - mean(abs(ome2_sim - ome2_meas)) / mean(abs(ome2_meas));
    
% end

