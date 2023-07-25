%%  Use file explorer to select file(s) containing bolus fill data

% if you are comparing two populations using the same experimental
% setup. All files from your first population should be imported
% as data1 and those from your second population as data2. For example, the 
% variables that are to be compared can be electrode thickness (21 x 4 mm 
% vs 46 x 4 mm) temperature (37 C vs room temp solutions) , electrode
% configuration (G25 vs G23) and so on.

clear;clc; close all
numPopulations = 2;
numSubPopulations = 2;

for i = 1:numPopulations
    cd 'C:\Users\mohamed\OneDrive - Cleveland State University\Lab\UroMonitor\Volume Sensing\Conductance Data';
    [fileName, pathName] = uigetfile({'*.txt;*.lvm'},'Select conductance files for population 1',...
    'MultiSelect','on');
    cd 'C:\Users\mohamed\OneDrive - Cleveland State University\Lab\UroMonitor\Volume Sensing\UroVolume';
    [~, ~, ext] = fileparts(string(fileName(1,1))); % get file extension
    if ext == '.lvm'
        populationData = get_data(fileName,pathName);
        data{1,i} = group_data(populationData);
    else
        for j = 1:numSubPopulations
            start = length(fileName)/numSubPopulations * j - ...
            (length(fileName)/numSubPopulations -1) ;
            finish = length(fileName)/numSubPopulations * j;
            subData = get_data(fileName(1,start:finish),pathName);
            conc(j) = get_concentration(fileName);
            subPopulationData{1,j} = getTableFromText(subData,conc(j));
        end
        data{1,i} = group_data(subPopulationData);
    end
end
clear i populationData subPopulationData subData


%% Plot Data
% Plot conductance (or conductivity) as a function of time
close all

c = lines(numSubPopulations);
plotTimeSeries = true;
plotMovingMedian = false;

for i = 1:numPopulations
    populationData = data{1,i};
    for j = 1:numSubPopulations
        subPopulationData = populationData{1,j};
        dependent_variable = 'conductance'; %% can also plot 'conductivity'
        if plotTimeSeries
           time = subPopulationData.time;
           G   = subPopulationData.G;
           fig1 = figure(1);

           ax(i) = subplot(numPopulations,1,i);
            if plotMovingMedian
                G_smooth = smoothdata(G,'movmedian');
                plot(G_smooth, 'k','LineWidth',3); hold on;
            end
            plot(time,G,'o', 'Color', c(i,:)); hold on;
            grid on; ylabel(dependent_variable); xlabel('Time (s)'), axis tight;
        end
    end
end
linkaxes(ax,'xy')
% Plot conductance vs infused volume

plotBoxPlot = true;
groups = unique(subPopulationData.vol_infused);
groups = groups(~isnan(groups));
for i = 1:numPopulations
    populationData = data{1,i};
    for j = 1:numSubPopulations
        subPopulationData = populationData{1,j};
        if plotBoxPlot
            dataGrouped{i,j} = getParameterGrouped(subPopulationData, ...
                dependent_variable,groups');
            fig2 = figure(2);
            %ax(i) = subplot(numPopulations,1,i);
            boxplot(dataGrouped{i,j}, cellstr(string(groups)),'colors', ...
                c(i,:)); hold on;
            grid on; ylabel(dependent_variable); xlabel('Volume (mL)');
        end
    end
end
linkaxes(ax,'xy')

% Add line connecting medians of subpopulation data

for i = 1:numPopulations
    populationData = data{1,i};
    for j = 1:numSubPopulations
        subPopulationData = populationData{1,j};
        fig2;
        %ax(i) = subplot(numPopulations,1,i);
        hold on;
        subPopulationDataMedian = get_median(subPopulationData,groups, ...
            dependent_variable,false);
        plot(subPopulationDataMedian,"Color", c(i,:)); hold on;
    end
end

%% Trial Data
for i = 1:numPopulations
    populationData = data{1,i};
    for j = 1:numSubPopulations
        subPopulationData = populationData{1,j};
        fig3 = figure(3);
        ax(i) = subplot(numPopulations,1,i);
        hold on;
        subPopulationDataMedian = get_median(subPopulationData,groups, ...
            dependent_variable,true);
        for trial = 1:size(subPopulationDataMedian,3)
            plot(subPopulationDataMedian(:,:,trial),"Color", c(j,:)); hold on;
        end
    end
end
%% Box Plot
dataGrouped = reshape(dataGrouped,[numPopulations, numSubPopulations]);
k = 0 ;
for i = 1:numPopulations
    for j = 1:numSubPopulations
        k = k +1;
        dataGroupedArranged(:,:,k) = dataGrouped{i,j};
    end
end

fig4 = figure(4);
title('Conductance vs Volume')
conductanceData = squeeze(mat2cell(permute(dataGroupedArranged, [1,3,2]),size(dataGrouped{1,1},1),k,ones(1,size(dataGrouped{1,1},2))));
boxplotGroup(conductanceData','PrimaryLabels', cellstr(string(groups)) ,...
   'InterGroupSpace', 3, 'Colors',c,'GroupType','WithinGroups') %'SecondaryLabels', {'10V', '5V' },
grid on; ylabel(dependent_variable); xlabel('Infused Volume (mL)')
%%  Get Median Conductance vs Volume
for i = 1:numPopulations
    populationData = data{1,i};
    for j = 1:numSubPopulations
        subPopulationData = populationData{1,j};
        medianConductance(:,j,i) = get_median(subPopulationData,groups,dependent_variable);
        % residuals is the difference between the measured conductance
        % sample and the median conductance
        for k = 1:length(groups)-1
            calSlope(k,j,i) = (medianConductance(k+1,j,i)-medianConductance(k,j,i));%/(groups(k+1)-groups(k));
        end

    end

end

figure(); plot(calSlope)