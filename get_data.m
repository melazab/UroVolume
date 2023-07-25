% This program reads signal express data (usually saved as text files)
% a typical file should have the following naming convention
% Sensor-concentrationNaClsoln-medium-Rsensevalue-trial#.txt
% An example of a file is 8.A-2.0NaCl-balloon-1kOhm-trial1.txt

function [data, numTrials]  = get_data(fileName,pathName)
%% Importing Conductance into MATLAB workspace

    if isa(fileName,'cell') % multiple files are selected 
        [~, ~, ext] = fileparts(string(fileName(1,1)));
        numTrials = length(fileName);
        if ext == '.txt'
            for i = 1:numTrials
                data{:,i}= load(fullfile(pathName,char(fileName(1,i))));
            end
        elseif ext == '.lvm'
            for i = 1:numTrials
                data{:,i} = import_lvm(char(fileName(1,i)),pathName);
            end
        end
    elseif isa(fileName,'char') % 1 file is selected
    [~, ~, ext] = fileparts(string(fileName));
    numTrials = 1;
        if ext == '.txt'
            data{numTrials} = load(fullfile(pathName,fileName));
            
        elseif ext == '.lvm'
            data  = import_lvm(fileName,pathName);
        end

    elseif ~pathName
        error('You did not select any files!')
    end
end
