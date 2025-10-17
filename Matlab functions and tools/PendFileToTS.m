function outputTS = PendFileToTS(fileName)

%     cd(fileparts(matlab.desktop.editor.getActiveFilename));
%     addpath(genpath('../'));
%     addpath(fullfile(parentFolder, '..\Tests\0416'));


%     % Check if fileName contains 'vert'
%     if ~contains(fileName, 'vert')
%         % If it doesn't contain 'wn', display an error message
%         error('A file with a white noise input must be selected.');
%     else
%         file = load(fileName);
%     end    
    
    file = load(fileName);
    
    % Convert output data into a timeseries
    fieldNames = fieldnames(file);
    data = file.(fieldNames{1});

    time = data(1,1:end-1902);
    position = [data(2,1903:end); data(3,1903:end)];
        
    outputTS = timeseries(position, time);
    outputTS.TimeInfo.Units = 'seconds';

%     % Convert input data into a timeseries
%     input = data(4,:);
%     inputTS = timeseries(input, time);
%     inputTS.TimeInfo.Units = 'seconds';
end