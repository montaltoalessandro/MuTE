function [entropyTerm covMtx] = shannonLinearEntropy(A)


    
    covMtx                   = cov(A');
    
    entropyTerm              = 0.5*log(det(covMtx))+0.5*size(A,1)*log(2*pi*exp(1));

return;