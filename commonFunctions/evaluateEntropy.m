function [entropy] = evaluateEntropy(A)
% 
% Syntax:
% 
% [entropy] = evaluateEntropy(A)
% 
% Description:
% 
% the function evaluates the binning entropy: evaluating the probability of
% each column of A and then evaluating the entropy as at row...
% 
% Input:
% 
% A                  : matrix with dimensions Series x numPoints
% 
% Output:
% 
% entropy            : entropy of A
% 
% Calling function:
% 
% function used to evaluate the shannon entropy or the conditional entropy
% 
% Example:
% 
% conditionalEntropy


    whileConditionMtx      = A';
    maxVectProb            = zeros(1,size(A,2));
    
    i = 1;
    while (~isempty(whileConditionMtx))
        currElement                           = whileConditionMtx(1,:);
        lengthWhileCondMtx                    = size(whileConditionMtx,1);
        idOccurrences                         = zeros(lengthWhileCondMtx,1);
        for m = 1 : lengthWhileCondMtx
            if (whileConditionMtx(m,:) == currElement)
                idOccurrences(m,1)            = m;
            end
        end
        idOccurrences                         = idOccurrences(idOccurrences(:,1) > 0,1);
        maxVectProb(1,i)                      = length(idOccurrences);
        whileConditionMtx(idOccurrences,:)    = [];
        i = i + 1;
    end
    
    [~,idProb]              = find(maxVectProb ~= 0);
    vectProb                = maxVectProb(1,idProb) ./ size(A,2);
    
    entropy = -sum(vectProb .* log(vectProb));
return;
    
