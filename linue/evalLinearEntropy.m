function [entropyTerm,covMtx,reconstructionError] = evalLinearEntropy(A)


    Y                        = A(1,:);

    X                        = A(2:end,:);
    
    coefficients             = Y/X;
    
    reconstuctedData         = coefficients * X;
    
    reconstructionError      = Y - reconstuctedData;
    
    covMtx                   = cov(reconstructionError');
    
    entropyTerm              = 0.5*log(det(covMtx))+0.5*size(Y,1)*log(2*pi*exp(1));

return;