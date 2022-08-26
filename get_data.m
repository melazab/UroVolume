% This program reads signal express data (usually saved as text files)
% a typical file should have the following naming convention
% Sensor-concentrationNaClsoln-medium-Rsensevalue-trial#.txt
% An example of a file is 8.A-2.0NaCl-balloon-1kOhm-trial1.txt

%%  Use file explorer to select file(s) containing conductance data
clear;clc;
[fileName, pathName] = uigetfile('*.txt','Select conductance files',...
    'MultiSelect','on');


% %% Manually inputing file path and name
% pathName = "C:\Users\moudy\OneDrive - Cleveland State University..." + ...
%     "\Lab\Uromonitor\SignalExpress Data\08-17-2022\1Vsin(100Hz)\";
% fileName = "8.A-0.5NaCl-balloon-1kOhm-trial1.txt";

%% Importing Conductance into MATLAB workspace
if isa(fileName,'cell')
    trial = length(fileName);
    for i = 1:length(fileName)
        G{:,i}= load(fullfile(pathName,char(fileName(1,i))));
    end    
elseif isa(fileName,'char')
    trial = 1;
    G{1} = load(fullfile(pathName,fileName));
else
    error('You did not select any files!')
end
