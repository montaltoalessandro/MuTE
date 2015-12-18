function [output] = neunetnue(data,methodParams)
    
    if (size(data,1) > size(data,2))
       data = data';
    end
%     data                  = data';
    
    idTargets             = methodParams.idTargets;
    idDrivers             = methodParams.idDrivers;
    infoSeries            = methodParams.infoSeries;
    multi_bivAnalysis     = methodParams.multi_bivAnalysis;
%     firstTermCaseVect     = params.firstTermCaseVect;
    secondTermCaseVect    = methodParams.secondTermCaseVect;
    
    numTargets               = length(idTargets);
    firstPredictionTerm      = zeros(1,numTargets);
    firstNetwork             = cell(1,numTargets);
    secondPredictionTerm     = zeros(1,numTargets);
    secondNetwork            = cell(1,numTargets);
    finalCandidates          = cell(1,numTargets);
    
    
    %% Evaluating the second entropy term
    secondIdCandidates    = generateConditionalTerm (infoSeries,idTargets,idDrivers,multi_bivAnalysis,secondTermCaseVect);
    
%     secondDelayMtx        = buildingDelayMtx(data,idTargets,secondIdCandidates);
    
%     disp('Evaluating Prediction Error');
    for i = 1 : numTargets
        if (strcmp(multi_bivAnalysis,'multiv'))
            if (i == 1)
                [secondNetwork{1,i},finalCandidates{1,i},secondPredictionTerm(1,i)]     = evalPredErrNN(data,methodParams,secondIdCandidates,i);
            elseif (i >= 2)
                [idIdenticalTar] = find(idTargets(1,1:i-1)==idTargets(1,i));
                if (~isempty(idIdenticalTar))
                    secondPredictionTerm(1,i)      = secondPredictionTerm(1,idIdenticalTar(1,length(idIdenticalTar)));
                    finalCandidates{1,i}           = finalCandidates{1,idIdenticalTar(1,1)}(:);
                    secondNetwork{1,i}             = secondNetwork{1,idIdenticalTar(1,length(idIdenticalTar))};
                else
                    [secondNetwork{1,i},finalCandidates{1,i},secondPredictionTerm(1,i)]     = evalPredErrNN(data,methodParams,secondIdCandidates,i);            
                end
            end
        else
            [secondNetwork{1,i},finalCandidates{1,i},secondPredictionTerm(1,i)]     = evalPredErrNN(data,methodParams,secondIdCandidates,i);
        end
    end
    
    parfor i = 1 : numTargets%parfor
            [firstNetwork{1,i},firstPredictionTerm(1,i)] = evalPredErrNN2(data,methodParams,secondNetwork{1,i},idTargets(1,i),idDrivers(:,i),finalCandidates{1,i}{1,1},secondPredictionTerm(1,i));
    end
    
    
    predictionError      = firstPredictionTerm - secondPredictionTerm;
    tmp                  = predictionError < 0;
    predictionError(tmp) = 0;
    
    output.firstEntropy           = firstPredictionTerm;
    output.secondEntropy          = secondPredictionTerm;
    output.transferEntropy        = predictionError;
    output.finalCandidatesMtx     = finalCandidates;
    output.firstNetwork           = firstNetwork;
    output.secondNetwork          = secondNetwork;
    output.params                 = methodParams;
    
return;