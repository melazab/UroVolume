function [concentration, plot_color] = choose_color(data,fileName)
    default_colors = [0 0.4470 0.7410; % Default MATLAB colors
        0.8500 0.3250 0.0980;
        0.9290 0.6940 0.1250;
        0.4940 0.1840 0.5560;
        0.4660 0.6740 0.1880;
        0.3010 0.7450 0.9330;
        0.6350 0.0780 0.1840];

    if isa(fileName,'cell')
        numTrials = length(fileName);
        for trial_number = 1:numTrials
            concentration(trial_number) = unique(data{1,trial_number}.conc);
        end
        [concentration, idx_sort] = sort(concentration);
        conc_number = length(unique(concentration));
        plot_color = [];
        for trial_number = 1:numTrials
            l = idx_sort(trial_number);
            idx = ceil(l/conc_number);
            plot_color(trial_number,:) = default_colors(idx,:,:);
        end
    end
end
