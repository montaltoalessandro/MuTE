function [ffwNetLearned,predictiveTerm] = evalPredErrNNUe(data,params,idCandidates,currIdTarget)
    

    bias                             = params.bias;
%     stopEpochPerc                    = params.stopEpochPerc;
    initType                         = 1;
    epochs                           = params.epochs;
    idTargets                        = params.idTargets;
    dividingPoint                    = params.dividingPoint;
    valStep                          = params.valStep;
    valThreshold                     = params.valThreshold;
    actFunc                          = params.actFunc;
    alpha                            = params.alpha;
    rangeW                           = params.rangeW;
    coeffHidNodes                    = params.coeffHidNodes;

    numCandidates                    = size(idCandidates{1,currIdTarget},1);
    hiddenNodes                      = fix(numCandidates*coeffHidNodes);
    ffwNetTmpLearned                 = cell(1,epochs);
    trainPredError                   = cell(1,epochs);
    delayMtx                         = cell(1,1);
    outputNodes                      = 1;

    validateError          = NaN*ones(1,epochs);
    %       initializing the first and second weight layers
    inputs           = numCandidates;
    firstW           = rangeW-2*rangeW*rand(hiddenNodes,inputs);
    secondW          = rangeW-2*rangeW*rand(outputNodes,hiddenNodes);
    if (bias == 1)
        firstBias   = rangeW-2*rangeW*rand(hiddenNodes,1);
        secondBias  = rangeW-2*rangeW*rand(outputNodes,1);
    end

%           build the network
    ffwNet = createFfw([inputs hiddenNodes outputNodes],actFunc,initType,bias);
    ffwNet.W{1} = firstW;
    ffwNet.W{2} = secondW;
%           taking in account the bias
    if (bias == 1)
        ffwNet.B{1} = firstBias;
        ffwNet.B{2} = secondBias;
    end

%           building trainSet, trainTarget, validationSet and
%           validationTarget
    delayMtx{1,1}       = buildingEntropyMtx(data,idTargets(1,currIdTarget),{idCandidates{1,currIdTarget}});
    dataSet             = delayMtx{1,1}{1,1};
    currNumPoints       = size(delayMtx{1,1}{1,1},2);
    lengthData          = fix(dividingPoint*length(dataSet));
    trainSet            = dataSet(2:end,1:lengthData)';
    trainTarget         = dataSet(1,1:lengthData)';
    validationSet       = dataSet(2:end,lengthData+1:length(dataSet))';
    validationTarget    = dataSet(1,lengthData+1:length(dataSet))';

%           building the learning params
    learnParams = createLearnParams(trainSet,trainTarget,{@derivSigmoid @derivIdentity});

%           setting learning params
    learnParams = setLearnParams(learnParams,'learningAlgorithm',params.learnAlg);

%           setting further learning parameters
    learnParams = setLearnParams(learnParams,'eta',params.eta);
    learnParams = setLearnParams(learnParams,'alpha',alpha);
    learnParams = setLearnParams(learnParams,'maxEpochs',params.numEpochs);
    learnParams = setLearnParams(learnParams,'wLayersToBeUpdated',[1 2]);
    if(strcmp(func2str(params.learnAlg),'resilientBackPropagation'))
        rbpParam    = createRBPParam(params.rbpIncrease,params.rbpDecrease,1E-03,1E-20,50);
        learnParams = setLearnParams(learnParams,'RBPParam',rbpParam);
    end

    m = 1;
    while (m <= epochs)
%               train the network
        [ffwNet,learnParams,~,trainPredError{1,m}] = ffwLearning(ffwNet,learnParams,0);
        trainPredError{1,m} = trainPredError{1,m} / currNumPoints;
        ffwNetTmpLearned{1,m} = ffwNet;

%               validate the network
        output             = ffwSim(ffwNet,validationSet);
        validateError(1,m) = RMSError(output,validationTarget,1);

%         if (mod(m,valStep) == 0 && m <= epochs - (stopEpochPerc*epochs))
        if (mod(m,valStep) == 0 && m <= epochs)
            err = sum(validateError(1,m-valStep+1:m))/valStep;
            relErr = abs(validateError(1,m) - err) / err;
            if (relErr <= valThreshold)
                a = m;
                m = epochs + 1;
            elseif((validateError(1,m) - err) / err >= 0)
                a = m - 1;
                m = epochs + 1;
            end
%         elseif (m >= epochs - (stopEpochPerc*epochs))
        elseif (m >= epochs)
            a = fix(m);
            m = epochs + 1;
        end
        m = m + 1;
    end
    predictiveTerm         = trainPredError{1,a}(end,1);
    ffwNetLearned          = ffwNetTmpLearned{1,a};

return;


