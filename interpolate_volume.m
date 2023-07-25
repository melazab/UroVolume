%% This function interpolates unmeasured volumes from bolus fills 
% By measuring G at volume = 0,60,120, ..., we can interpolate the
% conductance at between each fill
% manually adjust dV (Line 6) depending on how precise you want volume to
% be estimated

dV = 61; % setting dV to 6 results in 60/(61-1) =  1 mL steps
V_est = [];
dG = diff(G_avg);
for i = 1:n_fills-1
    slope = fill/dG(i);
    offset = volume(i)-slope*G_avg(i) ;
    V_est = cat(2,V_est,slope*linspace(G_avg(i),G_avg(i+1),dV)+offset);
end

G_interp = [];
for i = 1:n_fills-1
    slope = dG(i)/fill;
    offset = G_avg(i)-slope*volume(i) ;
    G_interp = cat(2,G_interp,slope*linspace(volume(i),volume(i+1),dV)+offset);
end

model = [G_interp' V_est'];

figure()
c = ['#EDB120'];
colororder(c)
plot(model(:,1),model(:,2),'p')
xlabel("Conductance (S)")
ylabel("Estimated Volume (mL)")
yticks(0:fill:v_f)

