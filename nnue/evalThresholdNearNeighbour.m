function [threshold] = evalThresholdNearNeighbour(normData,idTargets,idDrivers,generalIdConditionalTerm,methodParams,numNearNei,metric,funcDir,homeDir)


    numTargets            = size(idTargets,2);
    threshold             = zeros(1,numTargets);
    tauMin                = methodParams.tauMin;
    alphaPercentile       = methodParams.alphaPercentile;
    numSurrogates         = methodParams.numSurrogates;
    nPoints               = length(normData(:,1));


    if (methodParams.usePresent == 0)
        for i = 1 : numTargets%parfor
            dataShifted                  = normData;
            tmpValTransferEntropy        = zeros(1,numSurrogates);
            currIdDrivers                = find(idDrivers(:,i) > 0);
            numDrivers                   = length(currIdDrivers);
            driverShiftedMtx             = cell(1,numDrivers);
            for j  = 1 : numDrivers
                driverShiftedMtx{1,j}        = surrotimeshift(normData(:,idDrivers(currIdDrivers(j,1),i)),tauMin,numSurrogates);
            end
            
            for k = 1 : numSurrogates
                for driv = 1 : numDrivers
                    dataShifted(:,idDrivers(currIdDrivers(driv),i))      = driverShiftedMtx{1,driv}(:,k);%fix(6*rand(1,nPoints)) + 1
                end
                tmpValTransferEntropy(1,k) = PTEknn(dataShifted,generalIdConditionalTerm{1,i},idDrivers(:,i),idTargets(1,i),numNearNei,metric,funcDir,homeDir);
            end
            
            threshold(1,i)            = prctile(tmpValTransferEntropy,100*(1-alphaPercentile));
        end
    else
    %     If the user wants to use the present the idDrivers matrix is set with
    %     a redundant number of the same ids. getReducedDriv returns the
    %     idDrivers taken once
        reducedDrivers         = getRiducedDriv(idDrivers);
        for i = 1 : numTargets%parfor
            dataShifted                  = normData;
            tmpValTransferEntropy        = zeros(1,numSurrogates);
            currIdDrivers                = find(reducedDrivers(:,i) > 0);
            numDrivers                   = length(currIdDrivers);
            driverShiftedMtx             = cell(1,numDrivers);
            for j  = 1 : numDrivers
                driverShiftedMtx{1,j}        = surrotimeshift(normData(:,reducedDrivers(currIdDrivers(j,1),i)),tauMin,numSurrogates);
            end
            
            for k = 1 : numSurrogates
                for driv = 1 : numDrivers
                    dataShifted(:,driv)      = driverShiftedMtx{1,driv}(:,k);
                end
                tmpValTransferEntropy(1,k) = PTEknn(dataShifted,generalIdConditionalTerm{1,i},reducedDrivers(:,i),idTargets(1,i),numNearNei,metric,funcDir,homeDir);
            end        
            threshold(1,i)            = prctile(tmpValTransferEntropy,100*(1-alphaPercentile));
        end
    end

return;