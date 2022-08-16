V_est = [];
dG = diff(G_avg);
for i = 1:n_fills-1
    slope = fill/dG(i);
    offset = volume(i)-slope*G_avg(i) ;
    V_est = cat(2,V_est,slope*linspace(G_avg(i),G_avg(i+1),60)+offset);
end

G_interp = [];
for i = 1:n_fills-1
    slope = dG(i)/fill;
    offset = G_avg(i)-slope*volume(i) ;
    G_interp = cat(2,G_interp,slope*linspace(volume(i),volume(i+1),60)+offset);
end

model = [G_interp' V_est'];

plot(model(:,1),model(:,2))
xlabel("Conductance (S)")
ylabel("Estimated Volume (mL)")
yticks(0:fill:v_f)