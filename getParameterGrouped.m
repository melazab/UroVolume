function outputVar = getParamaterGrouped(inputVar, inputVar2, groups)
    if nargin<3
        groups = (0:50:500)';
    end

    switch inputVar2
        case 'conductance'
            parameter = inputVar.G;
        case 'conductivity'
            parameter = inputVar.sigma;
        case 'v_ai0' % Differential voltage across conductance-sensing electrodes (widely spaced)
            parameter = inputVar.v_ai0;
        case 'v_ai1' % RSE voltage across Sense Resistor (1kOhm)
            parameter = inputVar.v_ai1;
        case 'v_ai2' % Differential voltage across conductivity-sensing electrodes (closely-spaced)
            parameter = inputVar.v_ai2;

    end
    for i = 1:length(groups)
       G_group = parameter(inputVar.vol_infused ==groups(i));
       G_count(i) = length(G_group);
    end

    count_max = max(G_count,[],'all');
    
    for i = 1:length(groups)
        outputVar(:,i) = padWithNaNs(parameter(inputVar.vol_infused == groups(i)), NaN([count_max 1]));
    end
end