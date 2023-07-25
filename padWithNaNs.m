function  [signalOut1, signalOut2] = padWithNaNs(signalIn1, signalIn2)
        signalOut1 = signalIn1;
        signalOut2 = signalIn2;
        extraNans = max(length(signalIn1), length(signalIn2)) - min(length(signalIn1), length(signalIn2));
        
        if length(signalIn1) < length(signalIn2) % need to pad signalIn1
            signalOut1 = [signalIn1; NaN(extraNans,width(signalIn1))];
        elseif length(signalIn1) > length(signalIn2)% need to pad signalIn2
            signalOut2= [signalIn2; NaN(extraNans,width(signalIn2))];
        end


end