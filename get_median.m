function subPopulationDataMedian = get_median(subPopulationData, groups, dependent_variable,getMedianPerTrial)
    if nargin<4
        dependent_variable = 'conductance';
        getMedianPerTrial = false;
    end

    switch dependent_variable
        case 'conductance'
            parameter = subPopulationData.G;

        case 'conductivity'
             parameter = subPopulationData.sigma;

        case 'v_ai0'
            parameter = subPopulationData.v_ai0;
            
        case 'v_ai1'
            parameter = subPopulationData.v_ai1;
            
        case 'v_ai2'
            parameter = subPopulationData.v_ai2;
           
    end

    for i = 1:length(groups)
        samples = parameter(subPopulationData.vol_infused == groups(i));
        subPopulationDataMedian(:,i) = median(samples);
    end
    
    if getMedianPerTrial == true
        trial_idx =[find(subPopulationData.time ==0); height(subPopulationData)+1];
        numTrials = length(trial_idx)-1;
        for trial = 1:numTrials
            start = trial_idx(trial);
            finish = trial_idx(trial+1)-1;
            for i = 1:length(groups)
                samples = parameter(subPopulationData.vol_infused(start:finish) ==groups(i));
                subPopulationDataMedian(:,i,trial) = median(samples);
            end
        end
    end

end