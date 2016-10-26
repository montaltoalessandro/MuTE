function [threshold] = evalNeuNetUeEntropySurrogates(data,idTargets,idDrivers,secondIdConditionalTerm,methodParams,numSurrogates,firstEntropyTerm)

    numTargets            = size(idTargets,2);
    threshold             = zeros(1,numTargets);
    tauMin                = methodParams.tauMin;
    alphaPercentile       = methodParams.alphaPercentile;
%     evalEntropyFun        = methodParams.entropyFun;
%     nPoints               = length(dataPreprocessed(1,:));


    if (methodParams.usePresent == 0)
        for i = 1 : numTargets%parfor
            dataShifted                  = data;
            tmpValTransferEntropy        = zeros(1,numSurrogates);
            currIdDrivers                = idDrivers(idDrivers(:,i)>0,i);%find(idDrivers(:,i) > 0);
            numDrivers                   = length(currIdDrivers);
            driverShiftedMtx             = cell(1,numDrivers);
            for j  = 1 : numDrivers
                driverShiftedMtx{1,j}        = surrotimeshift(data(currIdDrivers(j,1),:)',tauMin,numSurrogates);
            end
            
            for k = 1 : numSurrogates
                for driv = 1 : numDrivers
                    dataShifted(currIdDrivers(driv),:)      = driverShiftedMtx{1,driv}(:,k)';%fix(6*rand(1,nPoints)) + 1
                end
%                 entropyTerm                  = evalEntropyFun(dataShifted,idTargets(1,i),{secondIdConditionalTerm{1,i}});
                [secondNetwork,entropyTerm]     = evalPredErrNNUe(dataShifted,methodParams,{secondIdConditionalTerm{1,i}},1);
                tmpValTransferEntropy(1,k)   = firstEntropyTerm(1,i) - entropyTerm;
            end
            
            threshold(1,i)            = prctile(tmpValTransferEntropy,100*(1-alphaPercentile));
        end
    else
    %     If the user wants to use the present the idDrivers matrix is set with
    %     a redundant number of the same ids. getReducedDriv returns the
    %     idDrivers taken once
        reducedDrivers         = getRiducedDriv(idDrivers);
        for i = 1 : numTargets
            dataShifted                  = data;
            tmpValTransferEntropy        = zeros(1,numSurrogates);
            currIdDrivers                = reducedDrivers(reducedDrivers(:,i)>0,i);%find(reducedDrivers(:,i) > 0);
            numDrivers                   = length(currIdDrivers);
            driverShiftedMtx             = cell(1,numDrivers);
            for j  = 1 : numDrivers
                driverShiftedMtx{1,j}        = surrotimeshift(data(currIdDrivers(j,1),:)',tauMin,numSurrogates);%surrotimeshift(dataPreprocessed(reducedDrivers(currIdDrivers(j,1),i),:)',tauMin,numSurrogates);
            end
            
            for k = 1 : numSurrogates
                for driv = 1 : numDrivers
                    dataShifted(currIdDrivers(driv),:)      = driverShiftedMtx{1,driv}(:,k)';
                end
%                 entropyTerm                  = evalEntropyFun(dataShifted,idTargets(1,i),{secondIdConditionalTerm{1,i}});
                [secondNetwork,entropyTerm]     = evalPredErrNNUe(dataShifted,methodParams,{secondIdConditionalTerm{1,i}},1);
                tmpValTransferEntropy(1,k)   = firstEntropyTerm(1,i) - entropyTerm;
            end
            threshold(1,i)            = prctile(tmpValTransferEntropy,100*(1-alphaPercentile));
        end
    end

return;