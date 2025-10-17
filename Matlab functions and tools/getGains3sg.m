function gains = getGains3(gainsDir, phasesDir)

    load(gainsDir);
    load(phasesDir);
    
    gainVars = who('G3_*_*');
    phaseVars = who('phi3*');
    nGains = numel(gainVars);
    nPhases = numel(phaseVars);

    gainValues = [];
    phaseValues = [];
    amplitudeValues = [];
    omegaValues = [];

    for i = 1:nGains
        gain = eval(gainVars{i});
        phase = eval(phaseVars{i});
        parts = split(gainVars{i}, '_');
        
        amplitudeStr = strrep(parts{2}, 'x', '.');
        omegaStr = strrep(parts{3}, 'x', '.');
        
        amplitude = str2double(amplitudeStr);
        omega = str2double(omegaStr);
       
            
        gainValues = [gainValues; gain];
        phaseValues = [phaseValues; phase];
        amplitudeValues = [amplitudeValues; amplitude];
        omegaValues = [omegaValues; omega];
    end
    
    
    for i=2:length(staticGains)+1
        gainValues = [gainValues; staticGains(i-1)];
        phaseValues = [phaseValues; 0];
        amplitudeValues = [amplitudeValues; 0.1*i];
        omegaValues = [omegaValues; 1e-10];
    end
    

    gains = struct();
    gains.gain = gainValues;
    gains.phase = phaseValues;
    gains.amplitude = amplitudeValues;
    gains.omega = omegaValues;
    
%     % Display the resulting vectors
%     disp('Gain Values:');
%     disp(gainValues);
%     disp('Amplitude Values:');
%     disp(amplitudeValues);
%     disp('Omega Values:');
%     disp(omegaValues);

end
