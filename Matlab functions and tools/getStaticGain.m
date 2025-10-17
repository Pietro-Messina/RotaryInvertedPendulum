function response = getStaticGain(file)

    names = fieldnames(file);
    data = file.(names{1});
    
    figure
    plot(data(2,:) * 2 * pi / 2048);
    response = mean(data(2, 1650:end) * 2 * pi / 2048);
    
end

    

    
    
    
    
    
    