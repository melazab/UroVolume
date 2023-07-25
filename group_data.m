%%% This function combines trials of the same NaCl concentration into groups 
function outputVar = group_data(inputVar)

    if ~isa(inputVar,'cell') || ~any(size(inputVar))
            outputVar = inputVar;
            return
    else
        
        numTrials = length(inputVar);
    
        for  i = 1:numTrials
            if isa(inputVar{1,i}, 'table')
                conc(i) = get_concentration(inputVar{1,i});
            else
                outputVar = inputVar;
                return
            end
        end

        outputVar = {};
        [conc, idx_sort] = sort(conc);

        all_conc = unique(conc);

        for i = 1:length(all_conc)
            group_temp = table();
            for j = 1:numTrials
                if conc(idx_sort(j)) == all_conc(i)
                    temp = inputVar{1,j};
                else 
                    temp = [];
                end
               group_temp = cat(1,group_temp,temp);
            end
            outputVar{1,i} = group_temp;
        end
    end
end