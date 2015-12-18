function [driversCandidates] = getDrivCandidatesLagZero(infoSeries,idDrivers)
% 
% Syntax:
% 
% [driversCandidates] = getDrivCandidatesLagZero(infoSeries,idDrivers)
% 
% Description:
% 
% the function enables to evaluate the drivers' embedding terms at lag
% zero, taking in account the present of the driver series.
% 
% Input:
% 
% infoSeries              : matrix containing id of all series and, for
%                           each series, on the same row, maximum model
%                           order 'p', lag 'lag', delay 'del' and 
%                           flag to use its present
% 
% idDrivers               : matrix containing, in each column, the indeces 
%                           of the series chosen as drivers for the
%                           target in the corresponding column
% 
% Output:
% 
% driversCandidates       : cell array containing, for each target, 
% 
% Calling function:
% 
% 






    [maxLengthDriv numTargets]                   = size(idDrivers);
    driversCandidates                            = cell(1,numTargets);
    currDrivIdCandidates                         = zeros(max(infoSeries(:,2)).*maxLengthDriv, 2);
    

    for i = 1 : numTargets
        currDriv                 = idDrivers(:,i);
        z                        = 1;
        k                        = 1;
        while (~isempty(currDriv) && currDriv(1,1) ~= 0)
            currValDriv       = currDriv(1,1);
            idCurrValDriv     = find(currDriv == currValDriv);
            if (length(idCurrValDriv) > 1)
                tmpP                                       = infoSeries(currValDriv,2);
                tmpDrivCandidates                          = repmat(infoSeries(currValDriv,3:4),tmpP,1);
                tmpDrivCandidates                          = [tmpDrivCandidates (0:tmpP-1)'];
                drivCandidates                             = tmpDrivCandidates(:,2) + (tmpDrivCandidates(:,3).*tmpDrivCandidates(:,1));
                drivCandidates                             = [0;drivCandidates];
                currDrivIdCandidates((k:(k-1)+tmpP+1)',:)  = [(currValDriv)*ones(tmpP+1,1),drivCandidates];
                k = k + tmpP+1;
                currDriv(idCurrValDriv)                    = [];
%                 currDriv(currDriv == currValDriv)          = [];
            else
                tmpP                                       = infoSeries(currValDriv,2);
                tmpDrivCandidates                          = repmat(infoSeries(currValDriv,3:4),tmpP,1);
                tmpDrivCandidates                          = [tmpDrivCandidates (0:tmpP-1)'];
                drivCandidates                             = tmpDrivCandidates(:,2) + (tmpDrivCandidates(:,3).*tmpDrivCandidates(:,1));
                currDrivIdCandidates((k:(k-1)+tmpP)',:)    = [currValDriv*ones(tmpP,1),drivCandidates];
                k = k + tmpP;
                currDriv(idCurrValDriv)                    = [];
            end
            z    = z + 1;
        end
%         idNonZeroDriv             = find(currDrivIdCandidates(:,1) > 0);
        currDrivIdCandidates      = currDrivIdCandidates(currDrivIdCandidates(:,1) > 0,:);
        driversCandidates{1,i}    = currDrivIdCandidates;
        currDrivIdCandidates      = zeros(max(infoSeries(:,2)).*maxLengthDriv, 2);
    end

return;