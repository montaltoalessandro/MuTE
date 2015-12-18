% function [U ErrU] = learningSCNNGradient(U,trainSet,ffwNet,sigmaU,params)

%   d = size(trainSet,2);
%   k = size(ffwNet.W{2},2);
%  
%   % calcolo il gradiente della parte derivabile della funzione di errore
%   
%   gradF = -(2/d) * (trainSet - (U * ffwNet.W{2}')) * ffwNet.W{2} + (2 * params.eta / k) * (U - (trainSet * ffwNet.W{1}'));
%   
%   % calcolo l'argomento dell'operatore di soft thresholding
%   
%   argSoftThreshold = U - (1/(2 * sigmaU) * gradF);
%   lambda = params.tau /(k * sigmaU);
%   
%   % aggiorno U
%   
%   U = softThreshold(argSoftThreshold, lambda);
%   
%   ErrU = mean(mean(((trainSet - U * ffwNet.W{2}').^2)));
% return;

% vecchia funzione

function [W learnParams] = learningSCNNGradient(W,gradW,learnParams)

    [W learnParams] = gradientDescent(W,gradW,learnParams);
    argSoftThreshold = W{1} - (1/(2*learnParams.sigmaU) * gradW{1});
    lambda = learnParams.tau /(learnParams.numComps * learnParams.sigmaU);
    W{1} = softThreshold(argSoftThreshold, lambda);

return;










