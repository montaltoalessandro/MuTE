function [driversCandidates]      = getDriversCandidates(infoSeries,idDrivers)
% 
% Syntax:
% 
% [driversCandidates]      = getDriversCandidates(infoSeries,idDrivers)
% 
% Description:
% 
% the function returns all the driver candidate terms according to the
% idTargets and to the infoSeries matrices
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
% targetCandidates        : all the driver candidate terms
%
% Calling function        : the function is called when the generation of
%                           the conditionl terms of the drivers is required
% 
% Example:
% 
% generateConditionalTerm ; generateCondTermLagZero

    numTargets                   = size(idDrivers,2);
    driversCandidates            = cell(1,numTargets);

    for i = 1 : numTargets%parfor
    %         check if there are zero entries in the idDrivers column
%         idNonZeroEntries         = find(idDrivers(:,i) > 0);
        currDrivers              = idDrivers(idDrivers(:,i) > 0,i);
        currDriversMtx           = infoSeries(currDrivers,:);
    %         initialyzing the currentIdCandidates
        totalCurrentModelOrder   = sum(currDriversMtx(:,2));
        currDrivIdCandidates      = zeros(totalCurrentModelOrder,2);
    %         building currentIdCandidates
        k = 1;
        for j = currDrivers'
            tmpP                                       = infoSeries(j,2);
            tmpDrivCandidates                          = repmat(infoSeries(j,3:4),tmpP,1);
            tmpDrivCandidates                          = horzcat(tmpDrivCandidates,(0:tmpP-1)');
            drivCandidates                             = tmpDrivCandidates(:,2) + (tmpDrivCandidates(:,3).*tmpDrivCandidates(:,1));
            currDrivIdCandidates((k:(k-1)+tmpP)',:)    = [j*ones(tmpP,1),drivCandidates];
            k = k + tmpP;
        end
        driversCandidates{1,i}    = currDrivIdCandidates;
    end


return;