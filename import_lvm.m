function imported_table = import_lvm(fileName, pathName)

    opts = delimitedTextImportOptions("NumVariables", 8);
    % Specify range and delimiter
    opts.DataLines = [1, Inf];
    opts.Delimiter = "\t";
    
    % Specify column names and types
    opts.VariableNames = ["time", "conc", "vol_infused", "v_ai0", "v_ai1", "v_ai2", "G", "sigma"];
    opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double"];
    
    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Import the data
    imported_table = readtable(char(fullfile(pathName, fileName)), opts);
end