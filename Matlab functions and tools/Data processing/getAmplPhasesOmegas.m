function [gains, phases, omegas] = getAmplPhasesOmegas(methodName)
    
    cd(fileparts(matlab.desktop.editor.getActiveFilename));
    folderPath = fullfile('..\..\Tests', methodName);
    matFiles = dir(fullfile(folderPath, '*.mat'));

    gains = [];
    phases = [];
    omegas = [];
    
    for i = 1:length(matFiles)
        filePath = fullfile(folderPath, matFiles(i).name);
        fileData = load(filePath);
        [~, fileName, ~] = fileparts(matFiles(i).name);
        
        validFieldName = regexprep(fileName, '[()]', '_'); 
        validFieldName = regexprep(validFieldName, '\.', 'x'); 
        validFieldName = regexprep(validFieldName, 'sin', '_sin'); 
        
        pattern = sprintf('^TestSCTR_%s_', methodName);
        match = regexp(validFieldName, pattern, 'once');

        if match == 1
            parts = split(validFieldName, '_');
            voltage = strrep(parts{3}, 'x', '.');
            voltage = str2double(voltage);

            omega = strrep(parts{5}, 'x', '.');
            omega = str2double(omega);

            amp = getAmplitude(fileData, omega);
            if i == 1
                amp = voltage;
            end
            gain = amp / voltage;

            phase = getPhase(fileData, amp, omega);

            gains = [gains, gain];
            phases = [phases, phase];
            omegas = [omegas, omega];
        end
    end
end

