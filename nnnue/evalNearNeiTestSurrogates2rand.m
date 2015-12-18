function [threshold] = evalNearNeiTestSurrogates2rand(entropyMtx,alphaPercentile,numSurrogates,metric,numNearNei,funcDir,homeDir)
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
    


    conditionalMutualInformation     = zeros(1,numSurrogates);
    surroMtx                         = zeros(numSurrogates,numPoints);
    targetSurroMtx                   = zeros(numSurrogates,numPoints);
    
    for i = 1 : numSurrogates
        randIndeces             = randperm(numPoints);
        surroMtx(i,:)           = entropyMtx(end,randIndeces);
        randIndeces2            = randperm(numPoints);
        targetSurroMtx(i,:)     = entropyMtx(1,randIndeces2);
    end
    
    if (numSeries > 2)
        currEntropyMtx            = entropyMtx(2:end-1,:);
    else
        currEntropyMtx            = [];
    end
    
    for i = 1 : numSurrogates%parfor
        [conditionalMutualInformation(1,i)]        = evalConditionalMutualInfo([targetSurroMtx(i,:) ; currEntropyMtx ; surroMtx(i,:)]',metric,numNearNei,funcDir,homeDir);
    end
    
    threshold                        = prctile(conditionalMutualInformation,100*(1-alphaPercentile));
    

return;