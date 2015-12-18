function [ffwNetLearned,finalCandidates,predictiveTerm] = evalPredErrNN(data,params,idCandidates,currIdTarget)
    

    bias                             = params.bias;
%     stopEpochPerc                    = params.stopEpochPerc;
    initType                         = 1;
    epochs                           = params.epochs;
    threshold                        = params.threshold;
    idTargets                        = params.idTargets;
    dividingPoint                    = params.dividingPoint;
    valStep                          = params.valStep;
    valThreshold                     = params.valThreshold;
    actFunc                          = params.actFunc;
    alpha                            = params.alpha;
    rangeW                           = params.rangeW;
    coeffHidNodes                    = params.coeffHidNodes;

    candidatesWhileCondition         = idCandidates{1,currIdTarget};
    numCandidates                    = size(idCandidates{1,currIdTarget},1);
    hiddenNodes                      = fix(numCandidates*coeffHidNodes);
    candidatesMtx                    = zeros(numCandidates,2);
    predictiveError                  = zeros(1,numCandidates);
    ffwNetTmpLearned                 = cell(1,epochs);
    trainPredError                   = cell(1,epochs);
    ffwCandidates                    = cell(1,numCandidates);
    delayMtx                         = cell(1,numCandidates);
    outputNodes                      = 1;

    z = 1;
    while (~isempty(candidatesWhileCondition))
%         disp(['Number Candidates Chosen So Far   |  ' num2str(z)]);
        
        numCurrCandidates      = size(candidatesWhileCondition,1);
        vectTrainError         = zeros(1,numCurrCandidates);
        ffwLearned             = cell(1,numCurrCandidates);
        validateError          = NaN*ones(1,epochs);
        
%       initializing the first and second weight layers
        if (candidatesMtx == zeros(numCandidates,2))
            inputs      = 1;
            firstW      = rangeW-2*rangeW*rand(hiddenNodes,inputs);
            secondW     = rangeW-2*rangeW*rand(inputs,hiddenNodes);
%             firstW      = params.firstW;
%             secondW     = params.secondW;
%           taking in account the bias
            if (bias == 1)
                firstBias   = rangeW-2*rangeW*rand(hiddenNodes,1);
                secondBias  = rangeW-2*rangeW*rand(outputNodes,1);
            end
        else
            inputs      = length(candidatesMtx(candidatesMtx(:,1) > 0)) + 1;
            firstW      = [ffwNetLearned.W{1},rangeW-2*rangeW*rand(hiddenNodes,1)];
            secondW     = ffwNetLearned.W{2};
%           taking in account the bias
            if (bias == 1)
                firstBias   = ffwNetLearned.B{1};
                secondBias  = ffwNetLearned.B{2};
            end

        end
        

        
        for i = 1 : numCurrCandidates
% %             for the figures
%             close all;
            
%           taking the current candidates
            if (candidatesMtx == zeros(numCandidates,2))
                currCandidates      = candidatesWhileCondition(i,:);
            else
                currCandidates      = [candidatesMtx(candidatesMtx(:,1) > 0,:);candidatesWhileCondition(i,:)];
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
            delayMtx{1,z}       = buildingEntropyMtx(data,idTargets(1,currIdTarget),{currCandidates});
            dataSet             = delayMtx{1,z}{1,1};
            currNumPoints       = size(delayMtx{1,z}{1,1},2);
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
                
%                 if (mod(m,valStep) == 0 && m <= epochs - (stopEpochPerc*epochs))
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
%                 elseif (m >= epochs - (stopEpochPerc*epochs))
                elseif (m >= epochs)
                    a = fix(m);
                    m = epochs + 1;
                end
                m = m + 1;
            end
            vectTrainError(1,i) = trainPredError{1,a}(end,1);
            ffwLearned{1,i}     = ffwNetTmpLearned{1,a};
        end
        
        [predictiveError(1,z),idMinTrainErr]   = min(vectTrainError);
        ffwCandidates{1,z}                     = ffwLearned{1,idMinTrainErr};
        
%       stop condition with respect to the predictive error
        if ((z > 2 && (predictiveError(1,z-1)-predictiveError(1,z))/(predictiveError(1,1)-predictiveError(1,z)) >= threshold)...
            || z == 2 && predictiveError(1,1)-predictiveError(1,z) >= threshold)
            ffwNetLearned         = ffwCandidates{1,z};
            candidatesMtx(z,:)    = candidatesWhileCondition(idMinTrainErr,:);
            z = z+1;
            candidatesWhileCondition(idMinTrainErr,:) = [];
        elseif z == 1
            ffwNetLearned         = ffwCandidates{1,z};
            candidatesMtx(z,:)    = candidatesWhileCondition(idMinTrainErr,:);
            z = z+1;
            candidatesWhileCondition(idMinTrainErr,:) = [];
            predictiveTerm        = 0;
        else
            candidatesWhileCondition = [];
            ffwNetLearned            = ffwCandidates{1,z-1};
            predictiveTerm           = predictiveError(1,z-1);
        end
    end
    
    finalCandidates{1,1}  = candidatesMtx(candidatesMtx(:,1) > 0,:);

return;


