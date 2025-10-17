function gains = getGains0(gainsDir)

    load(gainsDir);
    
    vars = who('G0_*_*');
    nGains = numel(vars);

    gainValues = [];
    amplitudeValues = [];
    omegaValues = [];

    for i = 1:nGains
        gain = eval(vars{i});
        parts = split(vars{i}, '_');
        
        amplitudeStr = strrep(parts{2}, 'x', '.');
        omegaStr = strrep(parts{3}, 'x', '.');
        
        amplitude = str2double(amplitudeStr);
        omega = str2double(omegaStr);
     
        
        % Remove outliers : 4, 8, 16, 24, 32
        if omega == 4 || omega == 8 || omega == 16 || omega == 24 || omega == 32
           continue;
        end
        
        
        gainValues = [gainValues; gain];
        amplitudeValues = [amplitudeValues; amplitude];
        omegaValues = [omegaValues; omega];
    end

    gains = struct();
    gains.gain = gainValues;
    gains.amplitude = amplitudeValues;
    gains.omega = omegaValues;    
    
    % Display the resulting vectors
    % disp('Gain Values:');
    % disp(gainValues);
    % disp('Amplitude Values:');
    % disp(amplitudeValues);
    % disp('Omega Values:');
    % disp(omegaValues);

end
