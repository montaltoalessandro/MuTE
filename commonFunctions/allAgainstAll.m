function [tarDrivRows] = allAgainstAll (seriesVect)
% This function is useful when you want to investigate how each driver is
% influencing each target 
%
% Syntax:
% 
% [tarDrivRows] = allAgainstAll (serisVect)
%
% Inputs:
% 
% seriesVect          = vector containing the series id chosen
% 
% Outputs:
% 
% tarDrivRows         = matrix containing in the first row the repetitions
%                       of each target and in the second row the
%                       repetitions of all drivers
% 
% Calling function    : main function


    numSeries    = length(seriesVect);
    numAllDriv   = numSeries - 1;
    tarDrivRows  = zeros(2,numSeries*numAllDriv);
    
%   filling in target-driver matrix
    for i = 1:numSeries
        tarDrivRows(1,(numAllDriv*i) - numAllDriv +1 : numAllDriv*i) = ones(1,numAllDriv)*i;
        if (i ~= 1)
            tarDrivRows(2,(numAllDriv*i) - numAllDriv +1 : numAllDriv*i) = [1:i-1 i+1:numSeries];
        else
            tarDrivRows(2,(numAllDriv*i) - numAllDriv +1 : numAllDriv*i) = i+1:numSeries;
        end
    end
        
return;