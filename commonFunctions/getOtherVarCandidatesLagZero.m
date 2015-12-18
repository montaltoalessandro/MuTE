function [otherVarCandidates] = getOtherVarCandidatesLagZero(infoSeries,idTargets,idDrivers,idOthersLagZero)
% 
% Syntax:
% 
% [otherVarCandidates] = getOtherVarCandidatesLagZero(infoSeries,idTargets,idDrivers,idOtherLagZero)
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
% idOtherLagZero          : matrix containing the series id of the time
%                           series involved in the multivariate analysis,
%                           not considered as drivers and chosen to have
%                           lag zero terms
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
    
    if (isempty(idOthersLagZero))
        idOthersLagZero = zeros(1,numTargets);
    end

    for i = 1 : numTargets %parfor
%         check if there are entries greater than zero in the idDrivers column
%         idNonZeroEntries         = find(idDrivers(:,i) > 0);
        currDrivers              = idDrivers(idDrivers(:,i) > 0,i);
        currTarDriv              = [idTargets(1,i) ; currDrivers];
        currIdOtherLagZero       = idOthersLagZero(idOthersLagZero(:,i)>0,i);
%         getting the idOthers
        idOthersWithZero                 = idSeries;
        idOthersWithZero(currTarDriv,1)  = 0;
%         deleting the zero entries
        idOthersNonZeroEntries           = find(idOthersWithZero(:,1) > 0);
        currOthers                       = idOthersWithZero(idOthersNonZeroEntries,1);
        currOthersNoLagZero              = currOthers;
%         deleting the id series that have been chosen to have lag zero
        for j = 1:length(currIdOtherLagZero(:,1))
            currOthersNoLagZero(currOthersNoLagZero == currIdOtherLagZero(j,1)) = [];
        end
        currOthersNoLagZeroMtx           = infoSeries(currOthersNoLagZero,:);
    %         initialyzing the currentIdCandidates
        currOthersIdNoLagZero            = zeros((max(currOthersNoLagZeroMtx(:,2)) * (length(idOthersNonZeroEntries))),2);
        currOthersIdLagZero              = zeros(max(currOthersNoLagZeroMtx(:,2) * length(currIdOtherLagZero(:,1))) + length(currIdOtherLagZero(:,1)),2);
%         building the candidates with lag zero only for the chosen series
        l = 1;
        if (~isempty(currIdOtherLagZero))
            for j = currIdOtherLagZero'
                tmpP                                         = infoSeries(j,2);
                tmpOthersLagZero                             = repmat(infoSeries(j,3:4),tmpP,1);
                tmpOthersLagZero                             = horzcat(tmpOthersLagZero,(0:tmpP-1)');
                othersLagZero                                = tmpOthersLagZero(:,2) + (tmpOthersLagZero(:,3).*tmpOthersLagZero(:,1));
                othersLagZero                                = [0;othersLagZero];
                currOthersIdLagZero((l:(l-1)+tmpP+1)',:)     = [j*ones(tmpP+1,1),othersLagZero];
                l = l + tmpP+1;
            end
        end
    %         building the candidates without lag zero
        k = 1;
        if (~isempty(currOthersNoLagZero))
            for j = currOthersNoLagZero'
                tmpP                                       = infoSeries(j,2);
                tmpOthersNoLagZero                         = repmat(infoSeries(j,3:4),tmpP,1);
                tmpOthersNoLagZero                         = horzcat(tmpOthersNoLagZero,(0:tmpP-1)');
                othersNoLagZero                            = tmpOthersNoLagZero(:,2) + (tmpOthersNoLagZero(:,3).*tmpOthersNoLagZero(:,1));
                currOthersIdNoLagZero((k:(k-1)+tmpP)',:)   = [j*ones(tmpP,1),othersNoLagZero];
                k = k + tmpP;
            end
        end
        currOthersIdLagZero       = currOthersIdLagZero(currOthersIdLagZero(:,1)>0,:);
        currOthersIdNoLagZero     = currOthersIdNoLagZero(currOthersIdNoLagZero(:,1)>0,:);
        otherVarCandidates{1,i}   = [currOthersIdLagZero;currOthersIdNoLagZero];
    end

return;