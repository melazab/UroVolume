function [dataOut, timeOut]  = getSteadyStateResponse(dataIn, timeIn, threshold)
    if nargin<3
        threshold = 0.02;
    end
    dataOut = dataIn(abs(diff(dataIn))<threshold);
    timeOut = timeIn(abs(diff(dataIn))<threshold);
end