function [finalCandidatesMtx finalMutualInfo minEntropies finalDistance condMutualInfo threshold] = nearNeiFirstTermCondEnt(dataPreprocessed,idTargets,idCandidates,methodParams,metric,numNearNei)
% 
% Syntax:
% 
% [finalConditionalEntropy minEntropies finalCandidatesMtx condMutualInfo threshold] = evaluateNonUniformEntropy(dataPreprocessed,idTargets,idCandidates,methodParams)
% 
% 
% Description:
% 
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

alphaPercentile                = methodParams.alphaPercentile;
numSurrogates                  = methodParams.numSurrogates;
homeDir                        = methodParams.homeDir;
funcDir                        = methodParams.funcDir;
informationTransCriterionFun   = methodParams.informationTransCriterionFun;
surrogatesTestFun              = methodParams.surrogatesTestFun;
dataPreprocessed               = dataPreprocessed';
[~, numPoints]                 = size(dataPreprocessed);
numTargets                     = length(idTargets);
finalCandidatesMtx             = cell(1,numTargets);
minEntropies                   = cell(1,numTargets);
condMutualInfo                 = cell(1,numTargets);
threshold                      = cell(1,numTargets);
finalDistance                  = cell(1,numTargets);
finalMutualInfo                = zeros(1,numTargets);


%% Procedure repeated for each target
% parfor k = 1 : numTargets %parfor
%     starting point with a copy of all the potential candidates. Every
%     chosen term will be deleted from the list
    k                           = 1;
    candidatesWhileCondition    = idCandidates{1,k};
    numCandidates               = size(idCandidates{1,k},1);
    candidatesMtx               = zeros(numCandidates,2);
    shannonEntropyTarget        = nearNeiShannonEntropy (dataPreprocessed',metric,numNearNei,funcDir,homeDir);
    maxMutualInfoValues            = -10*ones(1,numCandidates);
    condMInfo                   = zeros(1,numCandidates);
    conditionalInfo             = zeros(1,numCandidates);
    cellDist                    = cell(1,numCandidates);
    th                          = zeros(1,numCandidates);
%     initial entropy to start the comparison useful to evaluate the
%     conditional mutual information
    maxMutualInfoValues(1,1)       = shannonEntropyTarget;
    z                           = 1;
    %% Step 1    |   Heart of the procedure:
%     during this while loop a new candidate is chosen if its conditional
%     mutual information is statically consistent. If the current embedding
%     term is chosen it'll be added to the other embedding terms and the
%     procedure starts again esamining the entropy contribution of each
%     term that it is not been chosen during the prevoius steps
    while (~isempty(candidatesWhileCondition(:)))
        numCurrCandidates      = size(candidatesWhileCondition,1);
        currMutualInfoVect        = zeros(1,numCurrCandidates);
        currMutualInfoMtx         = cell(1,numCurrCandidates);
        distances              = cell(1,numCurrCandidates);

        for j = 1 : numCurrCandidates
            currMutualInfoMtx{1,j} = zeros(numCurrCandidates+1,numPoints);
        end

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
                currCandidate       = [candidatesMtx(candidatesMtx(:,1) > 0,:);candidatesWhileCondition(i,:)];
                
            end

%             evaluating the conditional information
            [currMI currMIMtx]          = informationTransCriterionFun(dataPreprocessed,idTargets(1,k),{currCandidate},metric,numNearNei,funcDir,homeDir);
            currMutualInfoMtx{1,i}      = currMIMtx{1,1};
            currMutualInfoVect(1,i)     = currMI;
        end
        %% Step 2
        [maxMutualInfoValues(1,z+1) idMin]        = max(currMutualInfoVect);
        
        %% Step 3
%         evaluating the conditional mutual information        
        [conditionalInfo(1,z)]               = evalConditionalMutualInfo([currMutualInfoMtx{1,idMin}]',metric,numNearNei,funcDir,homeDir);
%         numSeries                       = size(currMutualInfoMtx{1,idMin},1);
        % Evaluate psi function
%         psiVar = psi(1:size(currMutualInfoMtx{1,idMin},2));

%         cd(funcDir);
%         if (numSeries > 2)
%             atria1                      = nn_prepare(currMutualInfoMtx{1,idMin}', metric);
%             [count1, ~]                 = range_search(currMutualInfoMtx{1,idMin}', atria1,(1:size(currMutualInfoMtx{1,idMin},2))',distance,0);
%             atria2                      = nn_prepare(currMutualInfoMtx{1,idMin}(2:end,:)', metric);
%             [count2, ~]                 = range_search(currMutualInfoMtx{1,idMin}(2:end,:)', atria2,(1:size(currMutualInfoMtx{1,idMin},2))',distance,0);
%             firstEntropyTerm            = (1/numPoints) * (sum(psi(count2+1)) - sum(psi(count1+1))) + (1/numPoints) * sum(log(2*distance));
%         else
%             atria                       = nn_prepare(currMutualInfoMtx{1,idMin}', metric);
%             [count, ~]                  = range_search(currMutualInfoMtx{1,idMin}', atria,(1:size(currMutualInfoMtx{1,idMin},2))',distance,0);
%             shannonEntropy              = (1/numPoints) * (-sum(psi(count+1))) + (1/numPoints) * sum(log(2*distance));
%             firstEntropyTerm            = shannonEntropy;
%         end
% 
% 
% 
%         condMInfo(1,z)                            = firstEntropyTerm - conditionalInfo;
        %% Step 4
    %     executing the surrogates test with the currEntropyMtx corresponding
    %     to the minimum entropy value
        th(1,z)            = surrogatesTestFun(currMutualInfoMtx{1,idMin},alphaPercentile,numSurrogates,metric,numNearNei,funcDir,homeDir);
        
        %% Step 5
        if (conditionalInfo(1,z) > th(1,z))
            candidatesMtx(z,:)    = candidatesWhileCondition(idMin,:);
            cellDist{1,z}         = distances{1,idMin};
            z = z + 1;
            candidatesWhileCondition(idMin,:) = [];
        elseif (conditionalInfo(1,z) <= th(1,z) && z == 1)
            disp('WARNING: according to this method there are no significant candidates');
            candidatesMtx(z,:)    = 0;
            cellDist{1,z}         = {zeros(1)};
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
    [~, idMinEntropyValues]        = find(maxMutualInfoValues ~= -10);
    minEntropies{1,k}              = maxMutualInfoValues(1,idMinEntropyValues);
    if (length(idMinEntropyValues) == 1)
        finalMutualInfo(1,k)       = maxMutualInfoValues(1,idMinEntropyValues);
    else
        finalMutualInfo(1,k)       = maxMutualInfoValues(1,idMinEntropyValues(1,end-1));
    end
%     storing the conditional mutual information
    [~,idCondMInfo]                = find(condMInfo > 0);
    condMutualInfo{1,k}            = condMInfo(1,idCondMInfo);
%     storing the threshold
    [~,idTh]                       = find(th ~= 0);
    threshold{1,k}                 = th(1,idTh);
%     storing the distances
    finalDistance{1,k}             = cellDist{1,z-1};
    
% end

return;
