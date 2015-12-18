function [reducedDrivers] = getRiducedDriv(idDrivers)
% 
% Syntax:
% 
% [reducedDrivers] = getRiducedDriv(idDrivers)
% 
% Description:
% 
% 
% 
% Input:
% 
% 
% 
% Output:
% 
% 
% 
% Calling function:
% 
% 


    [maxLengthDriv numTargets]                   = size(idDrivers);
    reducedDrivers                               = zeros(maxLengthDriv,numTargets);
    rowFinalDrivToDelete                         = zeros(1,numTargets);

    for i = 1 : numTargets
        currDriv                 = idDrivers(:,i);
        z                        = 1;
        while (~isempty(currDriv) && currDriv(1,1) ~= 0)
            currValDriv                 = currDriv(1,1);
%             idCurrValDriv               = find(currDriv == currValDriv);
            reducedDrivers(z,i)         = currDriv(1,1);
            currDriv(currDriv == currValDriv)     = [];
            z = z + 1;
        end
        
        [~,idZeroFinalDriv]       = find(reducedDrivers(:,i) == 0);
        rowFinalDrivToDelete(1,i) = length(idZeroFinalDriv);
    end

    rowToDelete                                 = min(rowFinalDrivToDelete);
    reducedDrivers(end-rowToDelete+1:end,:)     = [];

return;