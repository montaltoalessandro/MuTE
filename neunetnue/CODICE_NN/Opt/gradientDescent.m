function [W learnParams] = gradientDescent(W, gradW, learnParams)
% function [W learnParams] = gradientDescent(W, gradW, learnParams)
% W and gradW are cell arrays of matrices.
    
    eta = learnParams.eta;
    Wlength=length(W); 
    for i=1:Wlength
        W{i}=W{i}-eta*gradW{i};
    end

return;