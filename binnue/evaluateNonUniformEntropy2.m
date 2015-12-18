function [conditionalEntropyTerm] = evaluateNonUniformEntropy2(dataPreprocessed,idTargets,idToRemove,finalCandidatesMtx,secondEntropyTerm,minEntropies,methodParams)
% 
% Syntax:
% 
% [conditionalEntropyTerm] = evaluateNonUniformEntropy2(dataPreprocessed,idTargets,idToRemove,finalCandidatesMtx,secondEntropyTerm,minEntropies,methodParams)
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
%         scalpCondCandidates                 = zeros(numCurrFinalCandidates,2);
%         sC = 1;
        for j = 1 : numCurrFinalCandidates
            tmpCandidate            = currCandidatesToRemove(j,1);
            if (methodParams.scalpConduction == 1)
              checkZeroLag   = currFinalCandidates{1,1}(currFinalCandidates{1,1}(:,2)==0,:);
%               zeroLag   = find(checkZeroLag(:,2) == 0);
%               if (zeroLag > 0)
%                   scalpCondCandidates(sC,:) = checkZeroLag(zeroLag,:);
%                   sC = sC + 1;
%               end
            end
            checkPresenceDriver     = find(currFinalCandidates{1,1}(:,1) == tmpCandidate);
            if (~isempty(checkPresenceDriver))
                currFinalCandidates{1,1}(checkPresenceDriver,:)  = [];
                numDriversDeleted    = numDriversDeleted + 1;
            else
                numDriversDeleted    = 0;
            end
        end
        if (methodParams.scalpConduction == 1 && (~isempty(checkZeroLag)))
%           scalpCondCandidates       = scalpCondCandidates(scalpCondCandidates(:,1)>0,:);
          currFinalCandidates{1,1}  = [currFinalCandidates{1,1};checkZeroLag];
          currFinalCandidates{1,1}  = unique(currFinalCandidates{1,1},'rows');
        end
        
        idConditionalTerm{1,1}              = currFinalCandidates{1,1};
        if (numDriversDeleted > 0 && ~isempty(currFinalCandidates{1,1}))
            conditionalEntropyTerm(1,i)     = conditionalEntropy(dataPreprocessed,idTargets(1,i),idConditionalTerm);
        elseif (numDriversDeleted > 0 && isempty(currFinalCandidates{1,1}))
            conditionalEntropyTerm(1,i)     = minEntropies{1,i}{1,1}(1,1); %shannon entropy
        else
            conditionalEntropyTerm(1,i)     = secondEntropyTerm(1,i);
        end
    end

return;