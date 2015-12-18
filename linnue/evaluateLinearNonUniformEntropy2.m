function [conditionalEntropyTerm] = evaluateLinearNonUniformEntropy2(dataPreprocessed,idTargets,idToRemove,finalCandidatesMtx,firstEntropyTerm,minEntropies)
% 
% Syntax:
% 
% [conditionalEntropyTerm] = evaluateNonUniformEntropy2(dataPreprocessed,idTargets,idDrivers,finalCandidatesMtx,firstEntropyTerm)
% 
% Description:
% 
% the function evaluates the first conditional entropy term removing, from
% the candidates chosen during the evaluation of the second entropy term,
% all the drivers. If there are any drivers to remove, the function
% evaluates again the conditional entropy otherwise the current conditional
% entropy will be the same as the previous one.
% 
% Input:
% 
% dataPreprocessed        : matrix containing only the nacessary data rows
%                           preprocessed
% 
% idTargets               : row vector contanining the indeces of the 
%                           series you want to study as target series
% 
% idToRemove              : matrix containing, in each column, the indeces 
%                           of the series chosen to be removed from the
%                           candidates set found during the previous step
% 
% finalCandidatesMtx      : cell array containing, for each target, the
%                           final embedding terms chosen
% 
% firstEntropyTerm        : vector of the minimum conditional entropy
%                           values for each target
% 
% Output:
% 
% conditionalEntropyTerm  : vector containing the conditional entropy terms
% 
% Calling function:
% 
% nonUniformTransferEntropy


    numTargets                   = size(idTargets,2);
    conditionalEntropyTerm       = zeros(1,numTargets);
    numDriversDeleted            = 0;
    
    for i = 1 : numTargets
        currCandidatesToRemove              = idToRemove(idToRemove(:,i) > 0,i);
        numCurrFinalCandidates              = length(currCandidatesToRemove);
        currFinalCandidates                 = finalCandidatesMtx{1,i};
        for j = 1 : numCurrFinalCandidates
            tmpCandidate            = currCandidatesToRemove(j,1);
            checkPresenceDriver     = find(currFinalCandidates{1,1}(:,1) == tmpCandidate);
            if (~isempty(checkPresenceDriver))
                currFinalCandidates{1,1}(checkPresenceDriver,:)  = [];
                numDriversDeleted    = numDriversDeleted + 1;
            else
                numDriversDeleted    = 0;
            end
        end
        
        idConditionalTerm{1,1}              = currFinalCandidates{1,1};
        if (numDriversDeleted > 0 && ~isempty(currFinalCandidates{1,1}))
            conditionalEntropyTerm(1,i)     = linearEntropy(dataPreprocessed,idTargets(1,i),idConditionalTerm);
        elseif (numDriversDeleted > 0 && isempty(currFinalCandidates{1,1}))
            conditionalEntropyTerm(1,i)     = minEntropies{1,i}{1,1}(1,1);
        else
            conditionalEntropyTerm(1,i)     = firstEntropyTerm(1,i);
        end
    end

return;