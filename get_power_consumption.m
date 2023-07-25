for i = 1:numTrials
    Vr(1:dur*n_fills,i) = data{i}(1:dur*n_fills,1);
end
Vr = Vr(1:dur*n_fills,:)./2; % divide by 2 because this is peak-peak Voltage
P = (Vr).^2; % Power expressed in milliWatts
%     P = Vr.^2/1000; % Power consumed by the 1kOhm sense resistor (in
%     Watts) x 1000 (Watts to milliWatts conversion)
figure()
colors = {'#0072BD','#0072BD','#0072BD','#D95319','#D95319',...
        '#D95319','#EDB120','#EDB120','#EDB120'};
colororder(colors)
for i  = 1:numTrials
    plot(Volume,P(:,i),'o')
    hold on
end
title("Power Consumption of sensor in balloon")
xticks(0:fill:v_f)
ylabel('Power (mW)')
xlabel('Volume (mL)')
hold off