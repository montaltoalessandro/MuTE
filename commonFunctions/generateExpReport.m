function [] = generateExpReport(copyDir,resultDir,params)
% Syntax

    methodNames          = fieldnames(params.methods);
    numMethods           = length(methodNames);

        for i = 1 : numMethods
            cd(resultDir)
            numTargets                         = length(params.methods.(methodNames{i,1}).idTargets);
            idDrivers                          = params.methods.(methodNames{i,1}).idDrivers;
            nameFiles                          = [methodNames{i,1} '*.mat'];
            subjFiles                          = dir(nameFiles);
            numSubj                            = length(subjFiles);
            significanceOnDrivers              = zeros(numSubj,numTargets);
            matrixTransferEntropy              = zeros(numSubj,(numTargets)+1);
    %         check if the pValues matrix is present
            checkPValuesField                  = load(subjFiles(1).name);
            fields                             = fieldnames(checkPValuesField);
            nameFields                         = checkPValuesField.(fields{1,1});
            if (isfield(nameFields,'pValue'))
                matrixPValues                  = zeros(numSubj,(numTargets)+1);
            end

            if (isfield(nameFields,'modelOrder'))
                modelOrder                     = zeros(numSubj,2);
            end

            if (isfield(nameFields,'testThreshold'))
                testThresholdMtx                     = zeros(numSubj,(numTargets)+1);
            end

            count = 0;
            for j = 1 : numSubj
                load(subjFiles(j).name);
                matrixTransferEntropy(j,2 : numTargets+1)                 = outputToStore.transferEntropy;
                matrixTransferEntropy(:,1)                                = (1:numSubj)';
                if (strcmp(methodNames{i,1},'nnnue') || strcmp(methodNames{i,1},'linnue')...
                        || strcmp(methodNames{i,1},'binnue') || strcmp(methodNames{i,1},'neunetnue'))
                    for k = 1 : numTargets
                        for l = 1 : length(idDrivers(:,k))
                            if (~isempty(find(outputToStore.finalCandidatesMtx{1,k}{1,1}(:,1) == idDrivers(l,k),1)))
                                count = count + 1;
                            end
                        end
                        if count > 0
                           significanceOnDrivers(j,k) = 1;
                        end
                        count = 0;
                    end
                end
                if (isfield(nameFields,'pValue'))
                    matrixPValues(j,2 : numTargets+1)                     = outputToStore.pValue;
                    matrixPValues(:,1)                                   = (1:numSubj)';
                end

                if (isfield(nameFields,'testThreshold'))
                    testThresholdMtx(j,2 : numTargets+1)                  = outputToStore.testThreshold;
                    testThresholdMtx(:,1)                                = (1:numSubj)';
                end

                if (isfield(nameFields,'bestOrder'))
                    modelOrder(j,1)                                      = outputToStore.bestOrder;
                end
            end

            if (isfield(nameFields,'pValue'))
                cd(copyDir)
                save([methodNames{i} '_matrixPValues'],'matrixPValues');
            end

            if (isfield(nameFields,'testThreshold'))
                cd(copyDir)
                save([methodNames{i} '_testThresholdMtx'],'testThresholdMtx');
            end
            cd(copyDir)
            save([methodNames{i,1} '_transferEntropyMtx'],'matrixTransferEntropy');
            if (strcmp(methodNames{i,1},'nnnue') || strcmp(methodNames{i,1},'linnue')...
                        || strcmp(methodNames{i,1},'binnue') || strcmp(methodNames{i,1},'neunetnue'))
                save([methodNames{i,1} '_significanceOnDriv'],'significanceOnDrivers');
            end
            cd(resultDir)
        end
    
    cd(copyDir)

return;