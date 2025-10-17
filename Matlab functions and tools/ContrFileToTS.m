function [outputTS, inputTS] = ContrFileToTS(fileName)

%     cd(fileparts(matlab.desktop.editor.getActiveFilename));
%     addpath(genpath('../'));
%     addpath(fullfile(parentFolder, '..\Tests\0416'));


    % Check if fileName contains 'Contr'
    if ~contains(fileName, 'Ctr')
        % If it doesn't contain 'wn', display an error message
        error('A file containing a control experiment must be selected.');
    else
        file = load(fileName);
    end    
    
    % Convert output data into a timeseries
    fieldNames = fieldnames(file);
    data = file.(fieldNames{1});

    time = data(1,:);
    position = [data(2,:); data(3,:)];
        
    outputTS = timeseries(position, time);
    outputTS.TimeInfo.Units = 'seconds';

    % Convert input data into a timeseries
    input = data(4,:);
    inputTS = timeseries(input, time);
    inputTS.TimeInfo.Units = 'seconds';
end