function [otherVarCandidates] = getOtherVarCandidates(infoSeries,idTargets,idDrivers)
% 
% Syntax:
% 
% [otherVarCandidates] = getOtherVarCandidates(infoSeries,idTargets,idDrivers)
% 
% Description:
% 
% the function returns all id candidates of the variables except the
% targets and the drivers
% 
% Input:
% 
% infoSeries              : matrix containing id of all series and, for
%                           each series, on the same row, maximum model
%                           order 'p', lag 'lag', delay 'del' and 
%                           flag to use its present
% 
% idTargets               : row vector contanining the indeces of the 
%                           series you want to study as target series
% 
% idDrivers               : matrix containing, in each column, the indeces 
%                           of the series chosen as drivers for the
%                           target in the corresponding column
% 
% Output:
% 
% otherVarCandidates      : all the variables id, except the idTargets and
%                           idDrivers
%
% Calling function        : the function is called when the generation of
%                           the conditionl terms of all the variables
%                           except the targets and the drivers is required
% Example:
% 
% generateConditionalTerm ; generateCondTermLagZero


    numTargets                   = size(idTargets,2);
    otherVarCandidates           = cell(1,numTargets);
    idSeries                     = infoSeries(:,1);

    parfor i = 1 : numTargets %parfor
%         check if there are entries greater than zero in the idDrivers column
%         idNonZeroEntries         = find(idDrivers(:,i) > 0);
        currDrivers              = idDrivers(idDrivers(:,i) > 0,i);
        currTarDriv              = [idTargets(1,i) ; currDrivers];
%         getting the idOthers
        idOthersWithZero                 = idSeries;
        idOthersWithZero(currTarDriv,1)  = 0;
%         deleting the zero entries
        idOthersNonZeroEntries           = find(idOthersWithZero(:,1) > 0);
        currOthers                       = idOthersWithZero(idOthersNonZeroEntries,1);
        currOthersMtx                    = infoSeries(currOthers,:);
    %         initialyzing the currentIdCandidates
        currOthersIdCandidates           = zeros(max(currOthersMtx(:,2)) * length(idOthersNonZeroEntries),2);
    %         building currentIdCandidates
        k = 1;
        for j = currOthers'
            tmpP                                       = infoSeries(j,2);
            tmpOthersCandidates                        = repmat(infoSeries(j,3:4),tmpP,1);
            tmpOthersCandidates                        = horzcat(tmpOthersCandidates,(0:tmpP-1)');
            othersCandidates                           = tmpOthersCandidates(:,2) + (tmpOthersCandidates(:,3).*tmpOthersCandidates(:,1));
%             if (infoSeries(j,5) == -1)
                currOthersIdCandidates((k:(k-1)+tmpP)',:)  = [j*ones(tmpP,1),othersCandidates];
                k = k + tmpP;
%             else
%                 othersCandidates                             = [0;othersCandidates];
%                 currOthersIdCandidates((k:(k-1)+tmpP+1)',:)  = [j*ones(tmpP+1,1),othersCandidates];
%                 k = k + tmpP+1;
%             end
        end
        otherVarCandidates{1,i}   = currOthersIdCandidates;
    end

return;