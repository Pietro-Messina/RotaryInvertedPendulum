function [outputTS, inputTS] = swFileToTS(fileName)

    % Check if fileName contains 'sw'
    if ~contains(fileName, 'sw')
        % If it doesn't contain 'sw', display an error message
        error('A file with a square wave input must be selected.');
    else
        file = load(fileName);
    end    
    
    % Convert output data into a timeseries
    fieldNames = fieldnames(file);
    data = file.(fieldNames{1});

    time = data(1,:);
    position = [data(3,:); data(4,:)];
        
    outputTS = timeseries(position, time);
    outputTS.TimeInfo.Units = 'seconds';

    % Convert input data into a timeseries
    input = data(2,:);
    inputTS = timeseries(input, time);
    inputTS.TimeInfo.Units = 'seconds';
end