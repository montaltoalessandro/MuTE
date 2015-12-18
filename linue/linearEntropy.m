function [entropyTerm,reconstructionError,entropyMtx] = linearEntropy(data,idTargets,idConditionalTerm)
% 
% Syntax:
% 
% [entropyTerm entropyMtx covMtx reconstructionError] = linearEntropy(data,idTargets,idConditionalTerm)
% 
% Description:
% 
% the function uses idConditionaTerm to build the rigth shifted matrix and
% processes the data through a probability estimating function and then
% evaluates the conditional entropy term
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
% entropyTerm             : vector containing the causal entropy for each
%                           target
% 
% entropyMtx              : cell array containing all the shifted matrices
%                           according to idTargets and idConditionalTerm
%                           inputs
% 
% covMtx                  : cell array containing the error covariance
%                           matrix
% 
% reconstructionError     : cell array containing the reconstruction error
%                           needed to evaluate the statistical test
% 
% Calling function:
% 
% every time the evaluation of a conditional entropy is required, so
% usually the calling function is the method function

    numTargets                    = length(idTargets);
    entropyTerm                   = zeros(1,numTargets);
    covMtx                        = cell(1,numTargets);
    reconstructionError           = cell(1,numTargets);
    


    %% Building the delay matrix
    entropyMtx                           = buildingEntropyMtx(data,idTargets,idConditionalTerm);

    %% Evaluating the conditional entropy
    parfor i = 1 : numTargets %parfor
        [entropyTerm(1,i),covMtx{1,i},reconstructionError{1,i}]    = evalLinearEntropy(entropyMtx{1,i});
    end

return;