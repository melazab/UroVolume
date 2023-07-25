function [volumeOut timeOut] = get_volume(timeIn, dur, fill, finalVolume,settlingTime)
    if nargin<5
        dur = 40; % input("Duration between volume fills (in seconds): ");
        fill =60; %input ("Volume of each bolus fill (in mL): ");
        finalVolume = 420; %input("Total volume infused (in mL):" );
        settlingTime = 15; % 15 seconds
    end
    n_fills = finalVolume/fill + 1; 
    volume = linspace(0, finalVolume, n_fills)';

%%  Account for transient increase in conductance per volume fill
% 1/2 of the total recording duration is enough settling time for
% conductance per volume fill


v = repmat(volume',[dur,1]);
[m,n] = size(v);
Volume = reshape(v,[m*n, 1]);
% set the initial samples of conductance measured at each volume fill
% to NaN to account for settling time.

cond = [NaN*ones(settlingTime,1); ones(dur - settlingTime,1)];
Cond = repmat(cond,[n_fills,1]);
volumeOut = Volume.*Cond;

end
