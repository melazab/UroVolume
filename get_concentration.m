% Determine concentration of NaCl solution (must meet naming convention) 
function conc = get_concentration(inputVar)
    if isa(inputVar,'table') && ismember('conc',inputVar.Properties.VariableNames)
        conc = unique(inputVar.conc);
    else
        conc = input('Enter concentration of NaCl solution: ');
    end
end


