function [subPopulationDataMean, subPopulationDataStdDev] = get_mean(subPopulationData, groups, dependent_variable)
    if nargin<3
        dependent_variable = 'conductance';
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
        [subPopulationDataStdDev(:,i), subPopulationDataMean(:,i)] = std(samples,[],'omitnan');
    end

end