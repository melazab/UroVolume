clear;clc;close
daqreset
d = daq("adi");
addoutput(d,"SMU1","A","voltage");
addinput(d,"SMU1","A","current");
addoutput(d,"SMU1","B","voltage");
addinput(d,"SMU1","B","current");
t = linspace(0,4e5,4e5)';
outScanData = 1*sin(2*pi*t/1000)+2 ;
inScanData = readwrite(d,[outScanData, outScanData]);
G_A = inScanData.SMU1_A_1./outScanData;
G_B = inScanData.SMU1_B_1./outScanData;

plot(G_A)
hold on;
plot(G_B)
hold off