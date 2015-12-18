function [threshold] = evalLinearTestSurrogates(entropyMtx,fixEntropyTerm,alphaPercentile,numSurrogates)
% 
% Syntax:
% 
% [threshold] = evalTestSurrogates(entropyMtx,fixEntropyTerm,alphaPercentile,numSurrogates)
% 
% Description:
% 
% the function shifts a numSurrogates time, in a random way, the data 
% matrix row corresponding to the current embedding term: the last one. For
% each shift it will be evaluated the conditional entropy. Afterwards the
% threshold will be evaluated.
% 
% Input:
% 
% entropyMtx              : cell array containing all the shifted matrices
%                           according to idTargets and idConditionalTerm
%                           inputs
% 
% fixEntropyTerm          : scalar; previous entropy term evaluated in the
%                           calling function
% 
% alphaPercentile         : scalar; percentile to set the threshold
% 
% numSurrogates           : scalar; number of surrogates to evaluate the
%                           statistical inference
% 
% Output:
% 
% threshold               : scalar; statistical threshold
% 
% Calling function:
% 
% evaluateNonUniformEntropy

    [numSeries numPoints]        = size(entropyMtx);

    conditionlMutualInformation      = zeros(1,numSurrogates);
    currEntropyTerm                  = zeros(1,numSurrogates);
    surroMtx                         = zeros(numSurrogates,numPoints);
    
    for i = 1 : numSurrogates
        randIndeces             = randperm(numPoints);
        surroMtx(i,:)           = entropyMtx(end,randIndeces);
    end
    
    
    for i = 1 : numSurrogates%parfor
        currEntropyTerm(1,i)    = evalLinearEntropy([entropyMtx(1:end-1,:) ; surroMtx(i,:)]);
    end
    
    conditionlMutualInformation(1,:) = fixEntropyTerm - currEntropyTerm;
    
    threshold                        = prctile(conditionlMutualInformation,100*(1-alphaPercentile));
    
    

return;