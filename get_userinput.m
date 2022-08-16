dur = input("Duration between volume fills (in seconds): ");
fill =input ("Volume of each bolus fill (in mL): ");
v_f = input("Total volume infused (in mL):" );
v_i = 0; % initial volume 
n_fills = v_f/fill + 1; 
volume = linspace(v_i,v_f, n_fills)