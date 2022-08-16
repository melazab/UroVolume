%%  Import conductance data file and path
get_data
%% Determine # of volume fills performed to get Conductance vs Volume plot
get_userinput

%%  Account for transient increase in conductance per volume fill
v = repmat(volume,[dur,1]);
[m,n] = size(v);
Volume = reshape(v,[m*n,1]);
% set the initial samples of conductance measured at each volume fill
% to NaN to account for settling time.

cond = [NaN*ones(dur/2,1); ones(dur/2,1)];
Cond = repmat(cond,[n_fills,1]);
Volume_cond = Volume.*Cond;

%% Plot Conductance vs Time
figure(1)
plot(G)
xlabel('Time (s)')
xticks(0:dur:dur*(n_fills))
ylabel('Conductance (S)')

%% Plot Conductance vs Volume
figure(2)
G_cond = G(~isnan(Volume_cond));
G_avg = mean(reshape(G_cond,[dur/2,n_fills]));
plot(volume, G_avg,'bo')
xlabel('Volume (mL)')
xticks(0:fill:v_f)
ylabel('Conductance (S)')