function [shanEntropy] = shannonEntropy(dataPreprocessed,idTargets)
% 
% Syntax:
% 
% [shanEntropy] = shannonEntropy(dataPreprocessed,idTargets)
% 
% Description:
% 
% the function evaluates the Shannon Entropy of each targat
% 
% Input:
% 
% dataPreprocessed        : matrix containing only the nacessary data rows
%                           preprocessed
% 
% idTargets               : row vector contanining the indeces of the 
%                           series you want to study as target series
% 
% Output:
% 
% shanEntropy             : vector containing the Shannon Entropies
% 
% Calling function:
% 
% predictiveInformation

    numTargets                  = length(idTargets);
    shanEntropy                 = zeros(1,numTargets);
    
    for i = 1 : numTargets
        shanEntropy(1,i)   = evaluateEntropy(dataPreprocessed(idTargets(1,i),:));
    end

return;