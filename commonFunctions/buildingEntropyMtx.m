function [entropyMtx] = buildingEntropyMtx(dataPreprocessed,idTargets,idConditionalTerm)
% 
% Syntax:
% 
% [entropyMtx] = buildingEntropyMtx(dataPreprocessed,idTargets,idConditionalTerm)
% 
% Description:
% 
% the function builds, for each target, a matrix containing the shifted
% series according to the idConditionalTerm input
% 
% Input:
% 
% dataPreprocessed        : matrix containing only the nacessary data rows
%                           preprocessed
% 
% idTargets               : row vector contanining the indeces of the 
%                           series you want to study as target series
% 
% idConditionalTerm       : cell array containing the id candidates for
%                           each target
% 
% Output:
% 
% entropyMtx              : cell array containing all the shifted matrices
%                           according to idTargets and idConditionalTerm
%                           inputs
% 
% Calling function:
% 
% conditionlEntropy

    numTargets                = length(idTargets);
    numPoints                 = size(dataPreprocessed,2);
    entropyMtx                = cell(1,numTargets);
    numDelays                 = zeros(1,numTargets);
    maxDelays                 = zeros(1,numTargets);
    
%     initializing the delayMtx

    for i = 1 : numTargets
        maxDelays(1,i)        = max(idConditionalTerm{1,i}(:,2));
        numDelays(1,i)        = size(idConditionalTerm{1,i},1);
        entropyMtx{1,i}       = zeros(numDelays(1,i) , numPoints - maxDelays(1,i));
    end

%     building the delayMtx

    parfor i = 1 : numTargets %parfor
        currIdConditionalTerm         = idConditionalTerm{1,i};
        for j = 1 : numDelays(1,i)
            entropyMtx{1,i}(j,:)      = dataPreprocessed(currIdConditionalTerm(j,1) , (maxDelays(1,i)+1-currIdConditionalTerm(j,2):numPoints-currIdConditionalTerm(j,2)));
        end
        entropyTarVect              = dataPreprocessed(idTargets(1,i) , maxDelays(1,i) + 1 : end);
        entropyMtx{1,i}             = [entropyTarVect ; entropyMtx{1,i}];
    end
    
    
return;