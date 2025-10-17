function [inputTS] = inFileToTS(fileName)
    file = load(fileName);

    fieldNames = fieldnames(file);
    data = file.(fieldNames{1});

    time = data(1,:);
    input = data(2,:);
    
    inputTS = timeseries(input, time);
    inputTS.TimeInfo.Units = 'seconds';
end