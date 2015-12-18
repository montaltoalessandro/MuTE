function [W learnParams] = learningPaddleRProp(W,gradW,learnParams)

    [W learnParams] = resilientBackPropagation(W,gradW,learnParams);
    argSoftThreshold = W{1} - ((1/(2*learnParams.sigmaU)) * (2/size(learnParams.trainSet,2)) * W{1});
    lambda = learnParams.tau /(learnParams.numComps * learnParams.sigmaU);
    W{1} = softThreshold(argSoftThreshold, lambda);

return;