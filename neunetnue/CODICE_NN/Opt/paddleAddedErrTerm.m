function [derW] = paddleAddedErrTerm(ffwNet,learnParams)

derW = -(2 * learnParams.lambdaAddedErr) * (learnParams.addedErrorTerm - learnParams.trainSet);

return;