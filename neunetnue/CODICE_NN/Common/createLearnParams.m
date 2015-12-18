function learnParams=createLearnParams(trainSet,trainTarget,derivActFunctions,learningAlgorithm,validSet,validTarget)
%function learnParams=createLearnParams(trainSet,trainTarget,derActivationFunctions,learningAlgorithm,validSet,validTarget)
% -- trainSet is a nxd matrix
% -- trainTarget is a nxc matrix
% -- derActivationFunctions is a cellarray of function pointers
% -- (optional) learnngAlgorithm is function pointer:
%       - @gradientDescent, @resilientBackPropagation, @conjugateGradient
%       - @gradientDescentWithMoment
% -- (optional) validSet is a mxd matrix
% -- (optional) validTarget is a mxc matrix
learnParams=struct();
learnParams.trainSet=trainSet;
learnParams.trainTarget=trainTarget;
learnParams.derivActFunctions=derivActFunctions;
learnParams.maxEpochs=100;
learnParams.batch=1;
learnParams.errorFunction=@SQError;
learnParams.derivErrorFunction=@derSQError;

if nargin <6
    learnParams.useValidation=false;
else
    learnParams.useValidation=true;
    learnParams.validSet=validSet;
    learnParams.validTarget=validTarget;
end
if nargin <4
    learnParams.learningAlgorithm=@gradientDescent;
else
    learnParams.learningAlgorithm=learningAlgorithm;
end

