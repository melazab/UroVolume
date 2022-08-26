dur = 40; %input("Duration between volume fills (in seconds): ");
fill =60; %input ("Volume of each bolus fill (in mL): ");
v_f = 420; % input("Total volume infused (in mL):" );
n_fills = v_f/fill + 1; 
volume = linspace(0, v_f, n_fills);


if trial==1
    conc = get_concentration(fileName);
else
    for i=1:trial
        conc{i,:} = get_concentration(fileName{i});
    end
end




