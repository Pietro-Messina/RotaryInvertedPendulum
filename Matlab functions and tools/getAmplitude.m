function amplitude = getAmplitude(file, f)

%     f = 4;
%     file = load('TestTOT_0.5sin(4).mat');
    
    names = fieldnames(file);
    data = file.(names{1});
    resolution = data(1,2);
    test_time = data(1,length(data)) - 5500*resolution - 200*resolution;
    pos = data(2,5500:length(data)-200) * 2 * pi / 2048;
    T = data(1,5500:length(data)-200);
    % -5500 to eliminate transient
    % -200 to avoid stopping on long peak (still motor)
    start = 1;
    while pos(start) == 0
        start = start + 1;
    end
    active_time = test_time - start*resolution;
    period = 2*pi/f;
    numb_periods = active_time / period;
    MPD = active_time / resolution / numb_periods * 0.7;                                              
    [maxima_y, maxima_x] = findpeaks(pos, 'MinPeakDistance', MPD);         
    [minima_y, minima_x] = findpeaks(-pos, 'MinPeakDistance', MPD);
    minima_y = - minima_y;
    max_numb = length(maxima_y);
    min_numb = length(minima_y);
    n = min([max_numb, min_numb]);
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
    
%     plot(pos)
%     hold on;
%     plot(pos)
%     hold on
%     for i=1:n
%         plot(maxima_x(i), maxima_y(i), 'ro')
%         plot(minima_x(i), minima_y(i), 'bo')
%     end

end

