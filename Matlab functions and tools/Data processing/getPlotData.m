function ExperimentsSorted = getPlotData(methodName)
    [gains, phases, omegas] = getAmplPhasesOmegas(methodName);

    gainsDB = 10*log(gains);
    phasesDeg = (phases*180)/pi;

    Experiments = [];
    Experiments(1,:) = omegas;
    Experiments(2,:) = gainsDB;
    Experiments(3,:) = phasesDeg;

    [~, order] = sort(Experiments(1, :));
    ExperimentsSorted = Experiments(:, order);


end