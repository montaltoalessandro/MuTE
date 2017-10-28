function [finalConditionalEntropy minEntropies finalCandidatesMtx condMutualInfo threshold] = evaluateNonUniformEntropy(dataPreprocessed,idTargets,idCandidates,methodParams)
% 
% Syntax:
% 
% [finalConditionalEntropy minEntropies finalCandidatesMtx condMutualInfo threshold] = evaluateNonUniformEntropy(dataPreprocessed,idTargets,idCandidates,methodParams)
% 
% 
% Description:
% 
% the function evaluates, for each target, the best embedding vectors and
% the corresponding entropy according to the non uniform embedding theory
% 
% 1) evaluating the conditonal entropy of the current embedding term, 
%    picked up from the current embedding term list, plus the previous 
%    chosen embedding terms, if at the current step are there any previous 
%    terms;
% 2) taking the minimum conditional entropy;
% 3) evaluating the conditional mutual information between the current
%    minimum entropy value and the previous one evaluated without the
%    current potential embedding term;
% 4) evaluating the statistical consistency of the current embedding term
%    through the generation of a statistical threshold by means the
%    surrogate procedure
% 4) if the conditional mutual information is greater then the threshold
%    then the current embedding term is chosen and added to the previous
%    ones. If the conditional mutual information in less then the threshold
%    then the procedure ends and will return the candidates chosen so far
% 5) storing the output to be returned
% 
% Input:
% 
% dataPreprocessed        : matrix containing only the nacessary data rows
%                           preprocessed
% 
% idTargets               : row vector contanining the indeces of the 
%                           series you want to study as target series
% 
% idCandidates            : cell array containing the id candidates for 
%                           each id target
% methodParams            : structure containing the current method 
%                           parameters
% 
% Output:
% 
% finalConditionalEntropy : vector of the minimum conditional entropy
%                           values for each target
% 
% minEntropies            : cell array containing, for each target, all the
%                           minimum conditional entropies corresponding to
%                           the added embedding term
% 
% finalCandidatesMtx      : cell array containing, for each target, the
%                           final embedding terms chosen
% 
% condMutualInfo          : cell array containing, for each target, all the
%                           conditional mutual informations corresponding 
%                           to the added embedding term
% 
% threshold               : cell array containing, for each target, all the
%                           thresholds useful to test the significancy of
%                           the added embedding term
% 
% Calling function:
% 
% nonUniformTransferEntropy

alphaPercentile             = methodParams.alphaPercentile;
numSurrogates               = methodParams.numSurrogates;
% multi_bivAnalysis           = methodParams.multi_bivAnalysis;

[~, numPoints]              = size(dataPreprocessed);
numTargets                  = length(idTargets);
finalCandidatesMtx          = cell(1,numTargets);



%% Procedure repeated for each target
% for k = 1 : numTargets
%     starting point with a copy of all the potential candidates. Every
%     chosen term will be deleted from the list
    k = 1;
    candidatesWhileCondition    = idCandidates{1,k};
    numCandidates               = size(idCandidates{1,k},1);
    candidatesMtx               = zeros(numCandidates,2);
    shannonEntropyTarget        = evaluateEntropy(dataPreprocessed(idTargets(1,k),:));
    minEntropyValues            = -10*ones(1,numCandidates);
    condMInfo                   = zeros(1,numCandidates);
    th                          = zeros(1,numCandidates);
%     initial entropy to start the comparison useful to evaluate the
%     conditional mutual information
    minEntropyValues(1,1)       = shannonEntropyTarget;
    z                           = 1;
    %% Step 1    |   Heart of the procedure:
%     during this while loop a new candidate is chosen if its conditional
%     mutual information is statically consistent. If the current embedding
%     term is chosen it'll be added to the other embedding terms and the
%     procedure starts again esamining the entropy contribution of each
%     term that it is not been chosen during the prevoius steps
    while (~isempty(candidatesWhileCondition(:)))
        numCurrCandidates      = size(candidatesWhileCondition,1);
        currEntropyVect        = zeros(1,numCurrCandidates);
        currEntropyMtx         = cell(1,numCurrCandidates);

%         for j = 1 : numCurrCandidates
%             currEntropyMtx{1,j} = zeros(numCurrCandidates+1,numPoints);
%         end

        numStackZero        = find(candidatesMtx(:,1) == 0);
        lengthNumStackZero  = length(numStackZero);

        for i = 1 : numCurrCandidates
%             if the chosen candidates matrix is empty the current
%             candidate is the i-th candidate esamined
            if (lengthNumStackZero == numCandidates)
%                 currCandidate{1,1}       = candidatesWhileCondition(i,:);
                currCandidate       = candidatesWhileCondition(i,:);
            else
%                 if the chosen candidates matrix contains other candidates
%                 the current candidates are the previous ones plus the
%                 i-th candidates esamined
                currCandidate            = [candidatesMtx(candidatesMtx(:,1) > 0,:);candidatesWhileCondition(i,:)];
            end

%             evaluating the conditional entropy
            [currEnt,currEntMtx]     = conditionalEntropy(dataPreprocessed,idTargets(1,k),{currCandidate});
            currEntropyMtx{1,i}      = currEntMtx{1,1};
            currEntropyVect(1,i)     = currEnt;
        end
        %% Step 2
        [minEntropyValues(1,z+1) idMin]        = min(currEntropyVect);
        %% Step 3
%         evaluating the conditional mutual information
        condMInfo(1,z)                         = minEntropyValues(1,z) - minEntropyValues(1,z+1);
        %% Step 4
    %     executing the surrogates test with the currEntropyMtx corresponding
    %     to the minimum entropy value
        th(1,z)            = evalTestSurrogates(currEntropyMtx{1,idMin},minEntropyValues(1,z),alphaPercentile,numSurrogates);
        %% Step 5
        if (condMInfo(1,z) > th(1,z))
            candidatesMtx(z,:)    = candidatesWhileCondition(idMin,:);
            z = z + 1;
            candidatesWhileCondition(idMin,:) = [];
        elseif (condMInfo(1,z) <= th(1,z) && z == 1)
            disp('WARNING: according to this method there are no significant candidates');
            candidatesMtx(z,:)    = 0;
            z = z + 1;
            candidatesWhileCondition = [];
        else
            candidatesWhileCondition = [];
        end
    end
        %% Step 6
%     storing the selected candidates
%     idNonZeroCandidates            = find(candidatesMtx(:,1) > 0);
%     finalCandidatesMtx{1,k}        = candidatesMtx(idNonZeroCandidates,:);
    finalCandidatesMtx{1,k}        = candidatesMtx(candidatesMtx(:,1) > 0,:);
%     storing the best entropy values and the conditional entropy
    [~, idMinEntropyValues]        = find(minEntropyValues ~= -10);
    minEntropies{1,k}              = minEntropyValues(1,idMinEntropyValues);
    if (length(idMinEntropyValues) == 1)
        finalConditionalEntropy(1,k)   = minEntropyValues(1,idMinEntropyValues);
    else
        finalConditionalEntropy(1,k)   = minEntropyValues(1,idMinEntropyValues(1,end-1));
    end
%     storing the conditional mutual information
    [~,idCondMInfo]                = find(condMInfo > 0);
    condMutualInfo{1,k}            = condMInfo(1,idCondMInfo);
%     storing the threshold
    [~,idTh]                       = find(th ~= 0);
    threshold{1,k}                 = th(1,idTh);
    
% end

return;
























