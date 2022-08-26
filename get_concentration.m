% Determine concentration of NaCl solution (must meet naming convention) 
function conc = get_concentration(Name)
    
    for idx =1:length(Name)
        if Name(idx) == '-'
            i_start = idx+1;
            break
        end
    end
    
    for idx = i_start:length(Name)
        if Name(idx) == '-'
            conc = Name(i_start:idx-1);
            break
        end
    end
end

