function [outputTS, amplitude, stopTime] = stepFileToTS(fileName)

    % Check if fileName contains 'wn'
    if ~contains(fileName, 'sca')
        % If it doesn't contain 'wn', display an error message
        error('A file with a step input must be selected.');
    else
        file = load(fileName);
    end    
    
    % Convert output data into a timeseries
    fieldNames = fieldnames(file);
    data = file.(fieldNames{1});

    % Define regular expression pattern
    pattern = 'TestTOT_(\d+(\.\d+)?)sca*';

    % Extract amplitude using regular expression
    matches = regexp(fileName, pattern, 'tokens');

    if ~isempty(matches)
        % Convert the matched string to a number
        amplitude = str2double(matches{1}{1});
    else
        disp('No amplitude found in the filename.');
    end
    
    time = data(1,:);
    position = [data(2,:); data(3,:)];
    stopTime = time(end);
        
    outputTS = timeseries(position, time);
    outputTS.TimeInfo.Units = 'seconds';
end