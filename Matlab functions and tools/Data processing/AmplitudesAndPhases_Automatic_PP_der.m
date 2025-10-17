clear
close all
clc

cd(fileparts(matlab.desktop.editor.getActiveFilename));
folderPath = '..\..\Tests\PP_der validation';
matFiles = dir(fullfile(folderPath, '*.mat'));

for i = 1:length(matFiles)
    filePath = fullfile(folderPath, matFiles(i).name);

    fileData = load(filePath);
    fieldName = fieldnames(fileData);

    [~, fileName, ~] = fileparts(matFiles(i).name);
    
    validFieldName = regexprep(fileName, '[()]', '_'); 
    validFieldName = regexprep(validFieldName, '\.', 'x'); 
    validFieldName = regexprep(validFieldName, 'sin', '_sin'); 
    
    patternTOT = '^TestSCTR_PPder_';
    prefixTOTGain = 'G';
    prefixTOTPhase = 'phi';
    matchTOT = regexp(validFieldName, patternTOT, 'once');
    if matchTOT == 1
        parts = split(validFieldName, '_');
        voltage = strrep(parts{3}, 'x', '.');
        voltage = str2double(voltage);
        frequency = strrep(parts{5}, 'x', '.');
        frequency = str2double(frequency);
        amp = getAmplitude(fileData, frequency);
        gainsVarName = [prefixTOTGain, '_', parts{3}, '_', parts{5}];
        gainsVarValue = amp / voltage;
        if i == 1
            gainsVarValue = 1;
        end
        eval([gainsVarName, ' = gainsVarValue']);
        
        phasesVarName = [prefixTOTPhase, '_', parts{3}, '_', parts{5}];
        phasesVarValue = getPhase(fileData, amp, frequency);
        eval([phasesVarName, ' = phasesVarValue']);

    end
    %note: no 2_12 / no 5_14
    
        
end

