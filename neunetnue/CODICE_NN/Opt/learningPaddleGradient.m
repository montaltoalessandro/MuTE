function [W learnParams] = learningPaddleGradient(W,gradW,learnParams)

    [W learnParams] = gradientDescent(W,gradW,learnParams);
    argSoftThreshold = W{1} - ((1/(learnParams.sigmaU)) * (1/size(learnParams.trainSet,2)) * gradW{1});
    lambda = learnParams.tau /(learnParams.numComps * learnParams.sigmaU);
    W{1} = softThreshold(argSoftThreshold, lambda);

return;