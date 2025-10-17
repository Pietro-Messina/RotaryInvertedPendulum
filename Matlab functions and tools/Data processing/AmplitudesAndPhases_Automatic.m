cd(fileparts(matlab.desktop.editor.getActiveFilename));
folderPath = '..\..\Tests\Tests for Amplitude';
matFiles = dir(fullfile(folderPath, '*.mat'));

for i = 1:length(matFiles)
    filePath = fullfile(folderPath, matFiles(i).name);

    fileData = load(filePath);
    fieldName = fieldnames(fileData);

    [~, fileName, ~] = fileparts(matFiles(i).name);
    
    validFieldName = regexprep(fileName, '[()]', '_'); 
    validFieldName = regexprep(validFieldName, '\.', 'x'); 
    validFieldName = regexprep(validFieldName, 'sin', '_sin'); 
    
    
    patternMotor = '^TestMotor';
    prefixMotorGain = 'G0';
    prefixMotorPhase = 'phi0';
    matchMotor = regexp(validFieldName, patternMotor, 'once');
    if matchMotor == 1
        parts = split(validFieldName, '_');
        voltage = strrep(parts{2}, 'x', '.');
        voltage = str2double(voltage);
        frequency = strrep(parts{4}, 'x', '.');
        frequency = str2double(frequency);
        amp = getAmplitude(fileData, frequency);
        gainsVarName = [prefixMotorGain, '_', parts{2}, '_', parts{4}];
        gainsVarValue = amp / voltage;
        eval([gainsVarName, ' = gainsVarValue']);
        
        phasesVarName = [prefixMotorPhase, '_', parts{2}, '_', parts{4}];
        phasesVarValue = getPhase(fileData, amp, frequency);
        eval([phasesVarName, ' = phasesVarValue']);
    end
    
    patternTOT = '^TestTOT';
    prefixTOTGain = 'G3';
    prefixTOTPhase = 'phi3';
    matchTOT = regexp(validFieldName, patternTOT, 'once');
    if matchTOT == 1
        parts = split(validFieldName, '_');
        voltage = strrep(parts{2}, 'x', '.');
        voltage = str2double(voltage);
        frequency = strrep(parts{4}, 'x', '.');
        frequency = str2double(frequency);
        amp = getAmplitude(fileData, frequency);
        gainsVarName = [prefixTOTGain, '_', parts{2}, '_', parts{4}];
        gainsVarValue = amp / voltage;
        eval([gainsVarName, ' = gainsVarValue']);
        
        phasesVarName = [prefixTOTPhase, '_', parts{2}, '_', parts{4}];
        phasesVarValue = getPhase(fileData, amp, frequency);
        eval([phasesVarName, ' = phasesVarValue']);

    end
    %note: no 2_12 / no 5_14
    
        
end

