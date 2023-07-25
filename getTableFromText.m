function outputVar = getTableFromText(inputVar,conc)
    outputVar = table();
    if isa(inputVar,'table') || isa(inputVar{1,1},'table')
        outputVar = inputVar;
        return
    end

    for i = 1:length(inputVar)
        
        trial_table = table();
        trial_table.time = (0:length(inputVar{1,i})-1)';
        trial_table.conc = conc*ones(size(trial_table.time));
        vol_infused = get_volume(trial_table.time,40, 60, 420,20);
        trial_table.vol_infused = padWithNaNs(vol_infused,trial_table.time);
        trial_table.v_ai0 = inputVar{1,i}(:,2);
        trial_table.v_ai1 = inputVar{1,i}(:,1);
        trial_table.v_ai2 = inputVar{1,i}(:,3);
        trial_table.G = inputVar{1,i}(:,4);
        trial_table.sigma = inputVar{1,i}(:,5);
        outputVar = cat(1, outputVar, trial_table);
    end
end