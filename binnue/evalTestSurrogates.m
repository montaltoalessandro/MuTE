function [threshold] = evalTestSurrogates(entropyMtx,fixEntropyTerm,alphaPercentile,numSurrogates)
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
%         here we shift the current candidate
        surroMtx(i,:)           = entropyMtx(end,randIndeces);
%         here we shift the target
%         surroMtx(i,:)           = entropyMtx(1,randIndeces);
    end
    
    if (numSeries > 2)
%         code for current candidate shifted
        firstEntropyMtx             = entropyMtx(2:end-1,:);
        secondEntropyMtx            = entropyMtx(1:end-1,:);
%         code for target shifted
%         firstEntropyMtx             = entropyMtx(2:end,:);
%         secondEntropyMtx            = entropyMtx(2:end,:);
    else
%         code for current candidate shifted        
        firstEntropyMtx             = [];
        secondEntropyMtx            = entropyMtx(1,:);
%         code for target shifted
%         firstEntropyMtx             = entropyMtx(end,:);
%         secondEntropyMtx            = entropyMtx(end,:);
    end
    
    for i = 1 : numSurrogates%parfor
%         code for current candidate shifted
        currFirstEntropyTerm    = evaluateEntropy([firstEntropyMtx;surroMtx(i,:)]);
        currSecondEntropyTerm   = evaluateEntropy([secondEntropyMtx ; surroMtx(i,:)]);
%         code for target shifted
%         currFirstEntropyTerm    = evaluateEntropy(firstEntropyMtx);
%         currSecondEntropyTerm   = evaluateEntropy([surroMtx(i,:) ; secondEntropyMtx]);
        currEntropyTerm(1,i)    = currSecondEntropyTerm - currFirstEntropyTerm;
    end
    
    conditionlMutualInformation(1,:) = fixEntropyTerm - currEntropyTerm;
    
    threshold                        = prctile(conditionlMutualInformation,100*(1-alphaPercentile));
    
    

return;