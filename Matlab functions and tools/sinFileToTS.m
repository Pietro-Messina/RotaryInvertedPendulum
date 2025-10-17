
% -------------------------------------------------------------------------
%   Data converter (from file notation and format to timeseries)
% -------------------------------------------------------------------------
% Converts data from the files into a timeseries format, useful for
% simulink simulation.
% 
% It takes as input a string containing the name of the file in the
% "Tests\Tests for amplitude" folder and outputs the timeseries.
% It automatically detects both the corresponding input voltage amplitude
% and omega from the file name, it also detects the 'TOT' string insode
% the file name to discern wether it contains data about a motor experiment
% or an experiment about the physical model.
% 
% For motor esperiments saves only the first encoders signal, while keeps
% both for physical model experiments

function [ts, omega, ampl] = sinFileToTS(fileName)
    file = load(fileName);
    
    % Output omega and amplitude
    numberPattern = '\d+(\.\d+)?';
    matches = regexp(fileName, numberPattern, 'match');
    
    omega = str2double(matches{end});
    ampl = str2double(matches{end-1});

    % Convert data into a timeseries
    fieldNames = fieldnames(file);

    fieldName = fieldNames{1};
    fieldValues = file.(fieldName);

    time = fieldValues(1,:);

    if contains(fileName, 'TOT')
        position = [fieldValues(2,:); fieldValues(3,:)];
    else
        position = fieldValues(2,:);
    end
    
    ts = timeseries(position, time);
    ts.TimeInfo.Units = 'seconds';
end