function [targetCandidates] = getTargetCandidates(infoSeries,idTargets)
% 
% Syntax:
% 
% [targetCandidates] = getTargetCandidates(infoSeries,idTargets)
% 
% Description:
% 
% the function returns all the target candidate terms according to the
% idTargets and to the infoSeries matrices
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
% Output:
% 
% targetCandidates        : all the target candidate terms
%
% Calling function        : the function is called when the generation of
%                           the conditionl terms of the targets is required
% 
% Example:
% 
% generateConditionalTerm ; generateCondTermLagZero

    numTargets                  = size(idTargets,2);
    targetCandidates            = cell(1,numTargets);

    for i = 1 : numTargets
        idT                                        = idTargets(i);
        tmpT                                       = infoSeries(idT,2);
        tmpTarCandidates                           = repmat(infoSeries(idT,3:4),tmpT,1);
        tmpTarCandidates                           = horzcat(tmpTarCandidates,(0:tmpT-1)');
        tarCandidates                              = tmpTarCandidates(:,2) + (tmpTarCandidates(:,3).*tmpTarCandidates(:,1));
        currTarIdCandidates                        = [idT*ones(tmpT,1),tarCandidates];
        targetCandidates{1,i}                      = currTarIdCandidates;
    end

return;