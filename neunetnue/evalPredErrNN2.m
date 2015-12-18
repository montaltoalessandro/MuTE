function [ffwNet,error] = evalPredErrNN2 (data,params,previousNet,idTargets,idToRemove,finalCandidatesMtx,secondPredictionTerm)


    actFunc                      = params.actFunc;
    bias                         = params.bias;
%     stopEpochPerc                = params.stopEpochPerc;
    initType                     = 1;
    epochs                       = params.epochs;
    valStep                      = params.valStep;
    valThreshold                 = params.valThreshold;
    alpha                        = params.alpha;
    dividingPoint                = params.dividingPoint;
    rangeW                       = params.rangeW;
    maxEpochs                    = fix(1/3*params.numEpochs);

    ffwNetTmpLearned             = cell(1,epochs);
    targetError                  = cell(1,epochs);
    validateError                = NaN*ones(1,epochs);
    numDriversDeleted            = 0;
    outputNodes                  = 1;
    coeffStep                    = 1;

    
    currCandidatesToRemove              = idToRemove(idToRemove(:,1) > 0,1);
    numCurrFinalCandidates              = length(currCandidatesToRemove);
    currFinalCandidates                 = finalCandidatesMtx;
    numTotalCandidates                  = size(finalCandidatesMtx,1);
%     idToTake                            = zeros(size(finalCandidatesMtx,1),1);
    idCandToRemove                      = zeros(size(finalCandidatesMtx,1),1);
    for j = 1 : numCurrFinalCandidates
        tmpCandidate            = currCandidatesToRemove(j,1);
        checkPresenceDriver     = find(currFinalCandidates(:,1) == tmpCandidate);
%         idNotDriver             = find(currFinalCandidates(:,1) ~= tmpCandidate);
        if (~isempty(checkPresenceDriver))
            fillPoint          = find(idCandToRemove == 0);
            fillPoint          = fillPoint(1,1);
            idCandToRemove(fillPoint:(fillPoint-1)+size(checkPresenceDriver,1),1)   = checkPresenceDriver;
            currFinalCandidates(checkPresenceDriver,:)  = zeros(length(checkPresenceDriver),2);
            numDriversDeleted    = numDriversDeleted + length(checkPresenceDriver);
        else
            numDriversDeleted    = 0;
        end
        
%         fillPoint          = find(idToTake == 0);
%         fillPoint          = fillPoint(1,1);
%         idToTake(fillPoint:(fillPoint-1)+size(idNotDriver,1),1)   = idNotDriver;
    end

%     idToTake          = idToTake(idToTake(:,1) > 0,1);
    idCandToRemove              = idCandToRemove(idCandToRemove(:,1) > 0,1);
    idToTake                    = (1:size(finalCandidatesMtx,1))';
    idToTake(idCandToRemove,:)  = [];

    inputs         = length(idToTake);
    hiddenNodes    = size(previousNet.W{1},1);
    if ((numDriversDeleted == 1 && numTotalCandidates ~= 1) || (numDriversDeleted > 0 && numDriversDeleted ~= numTotalCandidates))
        firstW         = previousNet.W{1}(:,idToTake);
        secondW        = previousNet.W{2};
    elseif (numDriversDeleted == 0)
        firstW         = previousNet.W{1};
        secondW        = previousNet.W{2};
    elseif (numDriversDeleted == numTotalCandidates)
        inputs = 1;
        targetFfwNet        = createFfw([inputs hiddenNodes outputNodes],actFunc,initType,bias);
        targetFfwNet.W{1}   = rangeW-2*rangeW*rand(hiddenNodes,inputs);%params.firstW;
        targetFfwNet.W{2}   = rangeW-2*rangeW*rand(inputs,hiddenNodes);%params.secondW;
        lengthData          = fix(dividingPoint*length(data));
        trainSet            = data(1,1:lengthData)';
        trainTarget         = data(1,1:lengthData)';
        validationSet       = data(1,lengthData+1:length(data))';
        validationTarget    = data(1,lengthData+1:length(data))';

%           building the learning params
        learnParams = createLearnParams(trainSet,trainTarget,actFunc);

%           setting learning params
        learnParams = setLearnParams(learnParams,'learningAlgorithm',params.learnAlg);

%           setting further learning parameters
        learnParams = setLearnParams(learnParams,'eta',params.eta);
        learnParams = setLearnParams(learnParams,'alpha',alpha);
        learnParams = setLearnParams(learnParams,'maxEpochs',maxEpochs);
        learnParams = setLearnParams(learnParams,'wLayersToBeUpdated',[1 2]);
        if(strcmp(func2str(params.learnAlg),'resilientBackPropagation'))
            rbpParam=createRBPParam(params.rbpIncrease,params.rbpDecrease,1E-03,1E-20,50);
            learnParams=setLearnParams(learnParams,'RBPParam',rbpParam);
        end

        m = 1;
        while (m <= epochs)

%               train the network
            [targetFfwNet,learnParams,~,targetError{1,m}] = ffwLearning(targetFfwNet,learnParams,0);
            targetError{1,m} = targetError{1,m} / length(trainSet);
            ffwNetTmpLearned{1,m} = targetFfwNet;

%               validate the network
            output             = ffwSim(targetFfwNet,validationSet);
            validateError(1,m) = RMSError(output,validationTarget,1);

%             if (mod(m,(coeffStep*valStep)) == 0 && m <= epochs - (stopEpochPerc*epochs))
            if (mod(m,(coeffStep*valStep)) == 0 && m <= epochs)
                err = sum(validateError(1,m-(coeffStep*valStep)+1:m))/(coeffStep*valStep);
                relErr = abs(validateError(1,m) - err) / err;

                if (relErr <= valThreshold)
                    a = m;
                    m = epochs + 1;
                elseif(validateError(1,m - (coeffStep*valStep) + 10) > validateError(1,m - (coeffStep*valStep) + 5))
                    a = m - (coeffStep*valStep) + 1;
                    m = epochs + 1;
                elseif((validateError(1,m) - err) / err >= 0)
                    a = m - 1;
                    m = epochs + 1;
                end
%             elseif (m >= epochs - (stopEpochPerc*epochs))
            elseif (m >= epochs)
                a = fix(m);
                m = epochs + 1;
            end
            m = m + 1;
        end
%         figure
%         plot(validateError(1:a),'*');
%         figure
%         plot(targetError{1,a},'r*');
        firstW         = ffwNetTmpLearned{1,a}.W{1};
        secondW        = ffwNetTmpLearned{1,a}.W{2};
        singleCandErr  = targetError{1,a}(1,end);
    end



    ffwNet         = createFfw([inputs hiddenNodes outputNodes],actFunc,initType,bias);
    ffwNet.W{1}    = firstW;
    ffwNet.W{2}    = secondW;

    if ((numDriversDeleted == 1 && numTotalCandidates ~= 1) || (numDriversDeleted > 0 && numDriversDeleted ~= numTotalCandidates))
        dataSet        = buildingEntropyMtx(data,idTargets(1,1),{currFinalCandidates(idToTake,:)});
        tSet           = dataSet{1,1}(2:end,1:fix(dividingPoint*length(dataSet{1,1})))';
        targetSeries   = dataSet{1,1}(1,1:fix(dividingPoint*length(dataSet{1,1})))';

        output         = ffwSim(ffwNet,tSet);

        error          = RMSError(output,targetSeries,1) / size(targetSeries,1);
    elseif (numDriversDeleted == 0)
        error          = secondPredictionTerm;
    elseif (numDriversDeleted == numTotalCandidates)
%         dataSet        = {[data(1,:);data(1,:)]};
        error          = singleCandErr;
    end

%     tSet           = dataSet{1,1}(2:end,1:fix(dividingPoint*length(dataSet{1,1})))';
%     targetSeries   = dataSet{1,1}(1,1:fix(dividingPoint*length(dataSet{1,1})))';
% 
%     output         = ffwSim(ffwNet,tSet);
% 
%     error          = RMSError(output,targetSeries,1) / size(targetSeries,1);

        

return;