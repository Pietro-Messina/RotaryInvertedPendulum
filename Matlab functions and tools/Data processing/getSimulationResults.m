function Experiments = getSimulationResults(ContrMethod, freqs, ampl)
    Experiments = struct();
    load_system('validation_simulations');
    Ts = 0.002;
    stopTime = 65;
    assignin('base', 'ContrMethod', ContrMethod)
    assignin('base', 'ampl', ampl)
    assignin('base', 'stopTime', stopTime)
    for freqInd = 1:length(freqs)
        assignin('base', 'frequency', freqs(freqInd))
        simOut = sim('validation_simulations');

        Experiments = buildResults(Experiments, simOut, Ts, 'derivative', freqs, freqInd);
        if ContrMethod == 0
            Experiments = buildResults(Experiments, simOut, Ts, 'observer', freqs, freqInd);

        elseif ContrMethod == 1
            Experiments = buildResults(Experiments, simOut, Ts, 'kalman', freqs, freqInd);
        end
    end
end

function ExpArray = buildResults(ExpArray, simOut, Ts, method, freqs, freqInd)
        if ~isfield(ExpArray, method)
            ExpArray.(method) = zeros(3,length(freqs));
        end        
        results = simOut.(method).';
        [amplitude, phase] = getParameters(freqs(freqInd), results, simOut.tout.', Ts);
        amplitudeDB = 10*log(amplitude);
        phaseDeg = (phase*180)/pi;
        ExpArray.(method)(1,freqInd) = freqs(freqInd);
        ExpArray.(method)(2,freqInd) = amplitudeDB;
        ExpArray.(method)(3,freqInd) = phaseDeg;
end

function [amplitude, phase] = getParameters(freq, pos, timeArray, resolution)
    %Get the amplitude
    period = 2*pi/freq;
    time = timeArray(end);
    numb_periods = time / period;
    MPD = time / resolution / numb_periods * 0.7;                                              
    [maxima_y, maxima_x] = findpeaks(pos, 'MinPeakDistance', MPD);         
    [minima_y, minima_x] = findpeaks(-pos, 'MinPeakDistance', MPD);
    minima_y = - minima_y;
    max_numb = length(maxima_y);
    min_numb = length(minima_y);
    n = min([max_numb, min_numb]);
    if freq == 30
        foo = 1;
    end
    if min_numb > max_numb
        minima_y = minima_y(2:min_numb);
        minima_x = minima_x(2:min_numb);
    end
    if min_numb < max_numb
        maxima_y = maxima_y(2:max_numb);
        maxima_x = maxima_x(2:max_numb);
    end
    amplitude = 0;
    for i=1:n
        amplitude = amplitude + maxima_y(i) - minima_y(i);
    end
    amplitude = amplitude / n / 2;

    %Get the phase
    sinusoid = @(w, t) amplitude*sin(freq*t+w(1))+w(2);
    estParam = lsqcurvefit(sinusoid, [0 0], timeArray, pos);
    phase = estParam(1);
end