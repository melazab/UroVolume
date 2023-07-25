clear;clc;close
d = daq("ni");

% Analog output
%
% Analog inputs
ch1 = addinput(d,"Dev3","ai0","Voltage");
ch2 = addinput(d,"Dev3","ai1","Voltage");
ch2.TerminalConfig = 'SingleEnded';


while 
    data = read(d,seconds(1));
    plot(data.Dev3_ai0)
     
end
