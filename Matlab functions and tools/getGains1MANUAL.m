function gains = getGains1(gainsDir)

    load(gainsDir);
    
    vars = who('G1_*_*');
    nGains = numel(vars);

    gainValues = [];
    amplitudeValues = [];
    omegaValues = [];

    for i = 1:nGains
        gain = eval(vars{i});
        parts = split(vars{i}, '_');
        
        amplitudeStr = parts{2};
        omegaStr = parts{3};
        
        % Check if the first character is '0' for amplitude
        if amplitudeStr(1) == '0'
            amplitude = str2double(['0.' amplitudeStr(2)]);
        else
            amplitude = str2double(amplitudeStr);
        end
        
        % Check if the first character is '0' for omega
        if omegaStr(1) == '0'
            omega = str2double(['0.' omegaStr(2)]);
        else
            omega = str2double(omegaStr);
        end
        
        % Append values to respective arrays
        gainValues = [gainValues; gain];
        amplitudeValues = [amplitudeValues; amplitude];
        omegaValues = [omegaValues; omega];
    end

    gains = struct();
    gains.gain = gainValues;
    gains.amplitude = amplitudeValues;
    gains.omega = omegaValues;
    
    % % Display the resulting vectors
    % disp('Gain Values:');
    % disp(gainValues);
    % disp('Amplitude Values:');
    % disp(amplitudeValues);
    % disp('Omega Values:');
    % disp(omegaValues);

end
