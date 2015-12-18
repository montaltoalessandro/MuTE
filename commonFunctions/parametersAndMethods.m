function [output,params] = parametersAndMethods(listRealizations,sampling,pointsToDiscard,channels,autoPairwiseTarDriv,handPairwiseTarDriv,resultDir,dataDir,copyDir,numProcessors,varargin)

    % Data: Time series in the rows
    realizations        = length(listRealizations);
    numSeries           = length(channels);
    output              = cell(1,realizations);
    
    
    % ***************************************************************************************************
    %% Setting methods
    
    method_caseVect = find(strcmp('binue',varargin));
    binue = 0;
    if (~isempty(method_caseVect))
        binue                                              = 1;
        binUnifIdTargets                                   = varargin{1,method_caseVect+1};
        binUnifIdDrivers                                   = varargin{1,method_caseVect+2};
        binUnifIdOthersLagZero                             = varargin{1,method_caseVect+3};
        binUnifModelOrder                                  = varargin{1,method_caseVect+4};
        binUnifAnalysisType                                = varargin{1,method_caseVect+5};
        binUnifQuantumlevels                               = varargin{1,method_caseVect+6};
        binUnifEntropyFun                                  = varargin{1,method_caseVect+7};
        binUnifPreProcessingFun                            = varargin{1,method_caseVect+8};
        binUnifCaseVect1                                   = varargin{1,method_caseVect+9};
        binUnifCaseVect2                                   = varargin{1,method_caseVect+10};
        binUnifNumSurrogates                               = varargin{1,method_caseVect+11};
        binUnifAlphaPercentile                             = varargin{1,method_caseVect+12};
        binUnifTauMin                                      = varargin{1,method_caseVect+13};
        binUnifGenerateCondTermFun                         = varargin{1,method_caseVect+14};
        binUnifUsePresent                                  = varargin{1,method_caseVect+15};
    end
    
    method_caseVect = find(strcmp('binnue',varargin));
    binnue = 0;
    if (~isempty(method_caseVect))
        binnue                                             = 1;
        binNonUnifIdTargets                                = varargin{1,method_caseVect+1};
        binNonUnifIdDrivers                                = varargin{1,method_caseVect+2};
        binNonUnifIdOthersLagZero                          = varargin{1,method_caseVect+3};
        binNonUnifModelOrder                               = varargin{1,method_caseVect+4};
        binNonUnifAnalysisType                             = varargin{1,method_caseVect+5};
        binNonUnifQuantumlevels                            = varargin{1,method_caseVect+6};
        binNonUnifEntropyFun                               = varargin{1,method_caseVect+7};
        binNonUnifPreProcessingFun                         = varargin{1,method_caseVect+8};
        binNonUnifCaseVect2                                = varargin{1,method_caseVect+9};
        binNonUnifNumSurrogates                            = varargin{1,method_caseVect+10};
        binNonUnifAlphaPercentile                          = varargin{1,method_caseVect+11};
        binNonUnifGenerateCondTermFun                      = varargin{1,method_caseVect+12};
        binNonUnifUsePresent                               = varargin{1,method_caseVect+13};
        binNonUnifScalpConduction                          = varargin{1,method_caseVect+14};
    end
    
    method_caseVect = find(strcmp('linue',varargin));
    linue = 0;
    if (~isempty(method_caseVect))
        linue                                              = 1;
        linUnifIdTargets                                   = varargin{1,method_caseVect+1};
        linUnifIdDrivers                                   = varargin{1,method_caseVect+2};
        linUnifIdOthersLagZero                             = varargin{1,method_caseVect+3};
        linUnifModelOrder                                  = varargin{1,method_caseVect+4};
        linUnifAnalysisType                                = varargin{1,method_caseVect+5};
        linUnifMinOrder                                    = varargin{1,method_caseVect+6};
        linUnifMaxOrder                                    = varargin{1,method_caseVect+7};
        linUnifOrderCriterion                              = varargin{1,method_caseVect+8};
        linUnifEntropyFun                                  = varargin{1,method_caseVect+9};
        linUnifCaseVect1                                   = varargin{1,method_caseVect+10};
        linUnifCaseVect2                                   = varargin{1,method_caseVect+11};
        linUnifGenerateCondTermFun                         = varargin{1,method_caseVect+12};
        linUnifUsePresent                                  = varargin{1,method_caseVect+13};
    end
    
    method_caseVect = find(strcmp('linnue',varargin));
    linnue = 0;
    if (~isempty(method_caseVect))
        linnue                                             = 1;
        linNonUnifIdTargets                                = varargin{1,method_caseVect+1};
        linNonUnifIdDrivers                                = varargin{1,method_caseVect+2};
        linNonUnifIdOthersLagZero                          = varargin{1,method_caseVect+3};
        linNonUnifModelOrder                               = varargin{1,method_caseVect+4};
        linNonUnifAnalysisType                             = varargin{1,method_caseVect+5};
        linNonUnifEntropyFun                               = varargin{1,method_caseVect+6};
        linNonUnifCaseVect                                 = varargin{1,method_caseVect+7};
        linNonUnifNumSurrogates                            = varargin{1,method_caseVect+8};
        linNonUnifAlphaPercentile                          = varargin{1,method_caseVect+9};
        linNonUnifGenerateCondTermFun                      = varargin{1,method_caseVect+10};
        linNonUnifUsePresent                               = varargin{1,method_caseVect+11};
    end

    method_caseVect = find(strcmp('nnue',varargin));
    nnue = 0;
    if (~isempty(method_caseVect))
        nnue                                               = 1;
        nearNeighUnifIdTargets                             = varargin{1,method_caseVect+1};
        nearNeighUnifIdDrivers                             = varargin{1,method_caseVect+2};
        nearNeighUnifIdOthersLagZero                       = varargin{1,method_caseVect+3};
        nearNeighUnifModelOrder                            = varargin{1,method_caseVect+4};
        nearNeighUnifAnalysisType                          = varargin{1,method_caseVect+5};
        nearNeighUnifCaseVect                              = varargin{1,method_caseVect+6};
        nearNeighUnifNumSurrogates                         = varargin{1,method_caseVect+7};
        nearNeighUnifMetric                                = varargin{1,method_caseVect+8};
        nearNeighUnifNumNearNei                            = varargin{1,method_caseVect+9};
        nearNeighUnifFuncDir                               = varargin{1,method_caseVect+10};
        nearNeighUnifHomeDir                               = varargin{1,method_caseVect+11};
        nearNeighUnifAlphaPercentile                       = varargin{1,method_caseVect+12};
        nearNeighUnifTauMin                                = varargin{1,method_caseVect+13};
        nearNeighUnifGenerateCondTermFun                   = varargin{1,method_caseVect+14};
        nearNeighUnifUsePresent                            = varargin{1,method_caseVect+15};
    end
    
    method_caseVect = find(strcmp('nnnue',varargin));
    nnnue = 0;
    if (~isempty(method_caseVect))
        nnnue                                              = 1;
        nearNeighNonUnifIdTargets                          = varargin{1,method_caseVect+1};
        nearNeighNonUnifIdDrivers                          = varargin{1,method_caseVect+2};
        nearNeighNonUnifIdOthersLagZero                    = varargin{1,method_caseVect+3};
        nearNeighNonUnifModelOrder                         = varargin{1,method_caseVect+4};
        nearNeighNonUnifAnalysisType                       = varargin{1,method_caseVect+5};
        nearNeighNonUnifCaseVect                           = varargin{1,method_caseVect+6};
        nearNeighNonUnifNumSurrogates                      = varargin{1,method_caseVect+7};
        nearNeighNonUnifMetric                             = varargin{1,method_caseVect+8};
        nearNeighNonUnifNumNearNei                         = varargin{1,method_caseVect+9};
        nearNeighNonUnifInfoTransCriterionFun              = varargin{1,method_caseVect+10};
        nearNeighNonUnifSurroTestFun                       = varargin{1,method_caseVect+11};
        nearNeighNonUnifFuncDir                            = varargin{1,method_caseVect+12};
        nearNeighNonUnifHomeDir                            = varargin{1,method_caseVect+13};
        nearNeighNonUnifAlphaPercentile                    = varargin{1,method_caseVect+14};
        nearNeighNonUnifGenerateCondTermFun                = varargin{1,method_caseVect+15};
        nearNeighNonUnifUsePresent                         = varargin{1,method_caseVect+16};
    end
    
    method_caseVect = find(strcmp('neunetue',varargin));
    neunetue = 0;
    if (~isempty(method_caseVect))
        neunetue                                             = 1;
        nnueIdTargets                                        = varargin{method_caseVect+1};
        nnueIdDrivers                                        = varargin{method_caseVect+2};
        nnueIdOtherLagZero                                   = varargin{method_caseVect+3};
        nnueModelOrder                                       = varargin{method_caseVect+4};
        nnuesecondTermCaseVect                               = varargin{method_caseVect+5};
        nnueAnalysisType                                     = varargin{method_caseVect+6};
        nnueEta                                              = varargin{method_caseVect+7};
        nnueAlpha                                            = varargin{method_caseVect+8};
        nnueActFunc                                          = varargin{method_caseVect+9};
        nnueNumEpochs                                        = varargin{method_caseVect+10};
        nnueBias                                             = varargin{method_caseVect+11};
        nnueEpochs                                           = varargin{method_caseVect+12};
        nnueDividingPoint                                    = varargin{method_caseVect+13};
        nnueValStep                                          = varargin{method_caseVect+14};
        nnueValThreshold                                     = varargin{method_caseVect+15};
        nnueLearnAlg                                         = varargin{method_caseVect+16};
        nnueRbpIncrease                                      = varargin{method_caseVect+17};
        nnueRbpDescrease                                     = varargin{method_caseVect+18};
        nnueRangeW                                           = varargin{method_caseVect+19};
        nnueCoeffHidNodes                                    = varargin{method_caseVect+20};
        nnueNumSurrogates                                    = varargin{method_caseVect+21};
        nnueTauMin                                           = varargin{method_caseVect+22};
        nnueAlphaPercentile                                  = varargin{method_caseVect+23};
        nnueGenCondTermFun                                   = varargin{method_caseVect+24};
        nnueUsePresent                                       = varargin{method_caseVect+25};
    end
    
    method_caseVect = find(strcmp('neunetnue',varargin));
    neunetnue = 0;
    if (~isempty(method_caseVect))
        neunetnue                                          = 1;
        nnData                                             = varargin{method_caseVect+1};
        nnIdTargets                                        = varargin{method_caseVect+2};
        nnIdDrivers                                        = varargin{method_caseVect+3};
        nnIdOtherLagZero                                   = varargin{method_caseVect+4};
        nnModelOrder                                       = varargin{method_caseVect+5};
        nnFirstTermCaseVect                                = varargin{method_caseVect+6};
        nnSecondTermCaseVect                               = varargin{method_caseVect+7};
        nnAnalysisType                                     = varargin{method_caseVect+8};
        nnEta                                              = varargin{method_caseVect+9};
        nnAlpha                                            = varargin{method_caseVect+10};
        nnActFunc                                          = varargin{method_caseVect+11};
        nnNumEpochs                                        = varargin{method_caseVect+12};
        nnBias                                             = varargin{method_caseVect+13};
        nnEpochs                                           = varargin{method_caseVect+14};
        nnThreshold                                        = varargin{method_caseVect+15};
        nnDividingPoint                                    = varargin{method_caseVect+16};
        nnValStep                                          = varargin{method_caseVect+17};
        nnValThreshold                                     = varargin{method_caseVect+18};
        nnLearnAlg                                         = varargin{method_caseVect+19};
        nnRbpIncrease                                      = varargin{method_caseVect+20};
        nnRbpDescrease                                     = varargin{method_caseVect+21};
        nnRangeW                                           = varargin{method_caseVect+22};
        nnCoeffHidNodes                                    = varargin{method_caseVect+23};
        nnGenCondTermFun                                   = varargin{method_caseVect+24};
        nnUsePresent                                       = varargin{method_caseVect+25};
    else
        nnData                                             = [];
    end

    % ***************************************************************************************************
    %% Setting the parameters for each method:
    
    if (binue)
        paramsBinTransferEntropy  = createBinueParams(numSeries,binUnifIdTargets,binUnifIdDrivers,binUnifIdOthersLagZero,binUnifModelOrder,binUnifAnalysisType,...
                                    binUnifQuantumlevels,binUnifEntropyFun,binUnifPreProcessingFun,binUnifCaseVect1,...
                                    binUnifCaseVect2,binUnifNumSurrogates,binUnifAlphaPercentile,binUnifTauMin,binUnifGenerateCondTermFun,binUnifUsePresent);
        if (autoPairwiseTarDriv(1) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsBinTransferEntropy.idTargets = tarDrivRows(1,:);
            paramsBinTransferEntropy.idDrivers = tarDrivRows(2,:);
        end
    end

    if (binnue)
        paramsNonUniformTransferEntropy = createBinnueParams(numSeries,binNonUnifIdTargets,binNonUnifIdDrivers,binNonUnifIdOthersLagZero,binNonUnifModelOrder,binNonUnifAnalysisType,...
                                          binNonUnifQuantumlevels,binNonUnifEntropyFun,binNonUnifPreProcessingFun,binNonUnifCaseVect2,...
                                          binNonUnifNumSurrogates,binNonUnifAlphaPercentile,binNonUnifGenerateCondTermFun,binNonUnifUsePresent,binNonUnifScalpConduction);
        if (autoPairwiseTarDriv(2) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsNonUniformTransferEntropy.idTargets = tarDrivRows(1,:);
            paramsNonUniformTransferEntropy.idDrivers = tarDrivRows(2,:);
        end
    end
    
    if (linue)
        paramsLinearTransferEntropy = createLinueParams(numSeries,linUnifIdTargets,linUnifIdDrivers,linUnifIdOthersLagZero,linUnifModelOrder,linUnifAnalysisType,...
                                      linUnifMinOrder,linUnifMaxOrder,linUnifOrderCriterion,linUnifEntropyFun,linUnifCaseVect1,linUnifCaseVect2,linUnifGenerateCondTermFun,linUnifUsePresent);
        if (autoPairwiseTarDriv(3) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsLinearTransferEntropy.idTargets = tarDrivRows(1,:);
            paramsLinearTransferEntropy.idDrivers = tarDrivRows(2,:);
        end
    end
    
    if (linnue)
        paramsLinearNonUniformTransferEntropy = createLinnueParams(numSeries,linNonUnifIdTargets,linNonUnifIdDrivers,linNonUnifIdOthersLagZero,linNonUnifModelOrder,...
                                                linNonUnifAnalysisType,linNonUnifEntropyFun,linNonUnifCaseVect,linNonUnifNumSurrogates,...
                                                linNonUnifAlphaPercentile,linNonUnifGenerateCondTermFun,linNonUnifUsePresent);
        if (autoPairwiseTarDriv(4) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsLinearNonUniformTransferEntropy.idTargets = tarDrivRows(1,:);
            paramsLinearNonUniformTransferEntropy.idDrivers = tarDrivRows(2,:);
        end
    end
    
    if (nnue)
        paramsUniTENearNeighbour = createNnueParams(numSeries,nearNeighUnifIdTargets,nearNeighUnifIdDrivers,nearNeighUnifIdOthersLagZero,nearNeighUnifModelOrder,...
                                                nearNeighUnifAnalysisType,nearNeighUnifCaseVect,nearNeighUnifNumSurrogates,nearNeighUnifMetric,nearNeighUnifNumNearNei,...
                                                nearNeighUnifFuncDir,nearNeighUnifHomeDir,nearNeighUnifAlphaPercentile,nearNeighUnifTauMin,...
                                                nearNeighUnifGenerateCondTermFun,nearNeighUnifUsePresent);
        if (autoPairwiseTarDriv(5) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsUniTENearNeighbour.idTargets = tarDrivRows(1,:);
            paramsUniTENearNeighbour.idDrivers = tarDrivRows(2,:);
        end
    end
    
    if (nnnue)
        paramsNonUniTENearNeighbour = createNnnueParams(numSeries,nearNeighNonUnifIdTargets,nearNeighNonUnifIdDrivers,nearNeighNonUnifIdOthersLagZero,nearNeighNonUnifModelOrder,...
                                      nearNeighNonUnifAnalysisType,nearNeighNonUnifCaseVect,nearNeighNonUnifNumSurrogates,nearNeighNonUnifMetric,nearNeighNonUnifNumNearNei,...
                                      nearNeighNonUnifInfoTransCriterionFun,nearNeighNonUnifSurroTestFun,nearNeighNonUnifFuncDir,nearNeighNonUnifHomeDir,nearNeighNonUnifAlphaPercentile,...
                                      nearNeighNonUnifGenerateCondTermFun,nearNeighNonUnifUsePresent);
        if (autoPairwiseTarDriv(6) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsNonUniTENearNeighbour.idTargets = tarDrivRows(1,:);
            paramsNonUniTENearNeighbour.idDrivers = tarDrivRows(2,:);
        end
    end
    
    if (neunetue)
        paramsUniNeuralNet = createNeunetueParams(numSeries,nnueIdTargets,nnueIdDrivers,nnueIdOtherLagZero,nnueModelOrder,nnuesecondTermCaseVect,...
                             nnueAnalysisType,nnueEta,nnueAlpha,nnueActFunc,nnueNumEpochs,nnueBias,nnueEpochs,nnueDividingPoint,...
                             nnueValStep,nnueValThreshold,nnueLearnAlg,nnueRbpIncrease,nnueRbpDescrease,nnueRangeW,nnueCoeffHidNodes,...
                             nnueNumSurrogates,nnueTauMin,nnueAlphaPercentile,nnueGenCondTermFun,nnueUsePresent);
        if (autoPairwiseTarDriv(7) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsUniNeuralNet.idTargets = tarDrivRows(1,:);
            paramsUniNeuralNet.idDrivers = tarDrivRows(2,:);
        end
    end
    
    if (neunetnue)
        paramsNonUniNeuralNet = createNeunetnueParams(numSeries,nnIdTargets,nnIdDrivers,nnIdOtherLagZero,nnModelOrder,nnFirstTermCaseVect,...
                                nnSecondTermCaseVect,nnAnalysisType,nnEta,nnAlpha,nnActFunc,nnNumEpochs,nnBias,nnEpochs,...
                                nnThreshold,nnDividingPoint,nnValStep,nnValThreshold,nnLearnAlg,nnRbpIncrease,nnRbpDescrease,...
                                nnRangeW,nnCoeffHidNodes,nnGenCondTermFun,nnUsePresent);
        if (autoPairwiseTarDriv(8) == 1)
            [tarDrivRows] = allAgainstAll (channels);
            paramsNonUniNeuralNet.idTargets = tarDrivRows(1,:);
            paramsNonUniNeuralNet.idDrivers = tarDrivRows(2,:);
        end
    end
    
    % ***************************************************************************************************
    %% Putting all the parameters in one structure
    
    if (binue)
        params.methods.binue = paramsBinTransferEntropy;
    end

    if (binnue)
        params.methods.binnue = paramsNonUniformTransferEntropy;
    end
    
    if (linue)
        params.methods.linue = paramsLinearTransferEntropy;
    end
    
    if (linnue)
        params.methods.linnue = paramsLinearNonUniformTransferEntropy;
    end
    
    if (nnue)
        params.methods.nnue = paramsUniTENearNeighbour;
    end
    
    if (nnnue)
        params.methods.nnnue = paramsNonUniTENearNeighbour;
    end
    
    if (neunetnue)
        params.methods.neunetnue = paramsNonUniNeuralNet;
    end
    
    if (neunetue)
        params.methods.neunetue = paramsUniNeuralNet;
    end
 
    % ***************************************************************************************************
    %% Calling methods
    
    if (numProcessors > 1)
    try
        disp('Destroing any existance matlab pool session');
        matlabpool('close');
%         poolobj = gcp('nocreate');
%         delete(poolobj);
    catch
        disp('No matlab pool session found');
    end
        matlabpool(numProcessors);
    end
    
    
    
    cd(dataDir);
    parfor i = 1 : realizations%parfor
        dataLoaded               = load([dataDir listRealizations(i,1).name]);
        if (isempty(nnData))
            dataNN               = dataLoaded.data(channels,1:sampling:(end-pointsToDiscard));
        else
            dataNN               = nnData;
        end
        output{1,i}              = callingMethods(dataLoaded.data(channels,1:sampling:(end-pointsToDiscard)),dataNN,params);
    end

    % *****************************************************************
    %% Storing output
    storingOutput(resultDir,listRealizations,params,output);

    cd(dataDir);
    generateExpReport(copyDir,resultDir,params);

    checkAutoPairwise = find(autoPairwiseTarDriv,1);
    checkHandPairwise = find(handPairwiseTarDriv,1);
    if (~isempty(checkAutoPairwise) || ~isempty(checkHandPairwise))
        reshapeResults(copyDir,resultDir,autoPairwiseTarDriv,handPairwiseTarDriv,params);
    end

%     methodNames      = fieldnames(params.methods);
%     numMethods       = length(methodNames);
%     cd(copyDir);
%     for a = 1:numMethods
%         if (strcmp(methodNames{a},'nonUniformTransferEntropy') || strcmp(methodNames{a},'linearNonUniformTransferEntropy')...
%                 || strcmp(methodNames{a},'nonUniTENearNeighbour') || strcmp(methodNames{a},'nonUniNeuralNet')...
%                 || strcmp(methodNames{a},'nonUniformTE_selectionVar'))
%             cd(resultDir);
%             modelOrder       = params.methods.(methodNames{a}).infoSeries(1,2);
%             numTargetsBinUnif       = length(params.methods.(methodNames{a}).idTargets);
%             for j = 1: numSeries-1 : numTargetsBinUnif
%                 finCanMtx           = zeros(realizations*modelOrder*numSeries,2);
%                 for i = 1 : realizations
%                     fillPoint = find(finCanMtx(:,1) == 0);
%                     fillPoint = fillPoint(1,1);
%                     currReal  = dir([methodNames{a} '*_' num2str(i) '.mat']);
%                     currReal  = load(currReal.name);
%                     finCanMtx(fillPoint:(fillPoint-1)+size(currReal.outputToStore.finalCandidatesMtx{1,j}{1,1},1),:) = currReal.outputToStore.finalCandidatesMtx{1,j}{1,1};
%                 end
%                 finCanMtx   = finCanMtx(finCanMtx(:,1)>0,:);
%                 finCanMtx1  = finCanMtx;
%                 countCandidates   = zeros(1,realizations*modelOrder*numSeries);
%                 countCandidates1  = zeros(1,realizations*modelOrder*numSeries);
%                 labels            = cell(1,realizations*modelOrder*numSeries);
%                 labels1           = cell(1,realizations*modelOrder*numSeries);
%                 idSeriesLag       = zeros(realizations*modelOrder*numSeries,2);
%                 l = 1;
%                 while (~isempty(finCanMtx))
%                     count          = 0;
%                     count1         = 0;
%                     tmpCandidate   = finCanMtx(1,1);
%                     tmpCandidate1  = finCanMtx1(1,:);
%                     tmpLengthFinCanMtx  = size(finCanMtx,1);
%                     for i = 1 : tmpLengthFinCanMtx
%                         if (tmpCandidate == finCanMtx(i,1))
%                             count = count+1;
%                             finCanMtx(i,:) = zeros(1,2);
%                         end
%                         if (tmpCandidate1 == finCanMtx1(i,:))
%                             count1 = count1+1;
%                             finCanMtx1(i,:) = zeros(1,2);
%                         end
%                     end
% 
%                     finCanMtx(finCanMtx(:,1)==0,:)   = [];
%                     finCanMtx1(finCanMtx1(:,1)==0,:) = [];
%                     countCandidates(1,l)  = count;
%                     countCandidates1(1,l) = count1;
%                     labels{1,l}           = num2str(tmpCandidate);
%                     labels1{1,l}          = num2str(tmpCandidate1);
%                     idSeriesLag(l,:)      = tmpCandidate1;
%                     l = l+1;
%                 end
%                 currDriv = getRiducedDriv(params.methods.(methodNames{a}).idDrivers(:,j));
%                 currTar  = params.methods.(methodNames{a}).idTargets(1,j);
%                 countCandidates  = countCandidates(countCandidates>0);
%                 countCandidates1 = countCandidates1(countCandidates1>0);
%                 label          = labels(1,1:l-1);
%                 label1         = labels1(1,1:l-1);
%                 idSeriesLag    = [idSeriesLag(1:l-1,:) countCandidates1'];
%                 cd(copyDir);
%                 titleLabel     = [methodNames{a} '_labels' '_tar_' num2str(currTar)];
%                 titleIdSeriesLag = [methodNames{a} '_idSeriesLag' '_tar_' num2str(currTar)];
%                 save(titleLabel,'label');
%                 save(titleIdSeriesLag,'idSeriesLag');
%                 cd(resultDir);
%                 f1 = figure;
%                 set(f1,'Position',[1 1 1680 1050]);  
%                 bar(countCandidates);
%                 set( gca, 'XTickLabel', label,'FontSize',12);
%                 title(['Series picked up by ' methodNames{a} '  | driver ' num2str(currDriv') ' ; target ' num2str(currTar)],'FontSize',16);
%                 xlabel('Series Index','FontSize',20);
%                 ylabel('Counting','FontSize',20);
%                 f1SaveTitle = [methodNames{a} '_histAllCandidates_driv_' num2str(currDriv') '_tar_' num2str(currTar)];
%                 cd(copyDir);
%                 saveas(f1,f1SaveTitle);
% 
%                 f2 = figure;
%                 set(f2,'Position',[1 1 1680 1050]);  
%                 bar(countCandidates1);
%                 set( gca, 'XTickLabel', label1,'FontSize',12);
%                 title(['Candidate picked up by ' methodNames{a} '  | driver ' num2str(currDriv') ' ; target ' num2str(currTar)],'FontSize',16);
%                 xlabel('Candidates','FontSize',20);
%                 ylabel('Counting','FontSize',20);
%                 f2SaveTitle = [methodNames{a} '_hist_driv_' num2str(currDriv') '_tar_' num2str(currTar)];
%                 cd(copyDir);
%                 saveas(f2,f2SaveTitle);
%                 cd(resultDir);
%             end
%             make3Dmatrix(copyDir,numSeries,modelOrder,methodNames{a});
%         end
%     end
    
    if (numProcessors > 1)
        matlabpool close;
%         poolobj = gcp('nocreate');
%         delete(poolobj);
    end
    
    
    
    
    
    
return;