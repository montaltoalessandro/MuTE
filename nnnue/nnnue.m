function [output] = nnnue(data,methodParams)
% 
% Syntax:
% 
% [output] = nonUniTENearNeighbour(data,methodParams)
% 
% Description:
% 
% 
% Input:
% 
% data                  : matrix data
% 
% methodParams          : structure containing the current method 
%                         parameters
% 
% Output:
% 
% output                : structure containing the first conditional
%                         entropy term, the second conditional entropy term
%                         and the transfer entropy for each target
% 
% Calling function:
% 
% callingMethods


    infoSeries                    = methodParams.infoSeries;
    idTargets                     = methodParams.idTargets;
    idDrivers                     = methodParams.idDrivers;
    idOthersLagZero               = methodParams.idOthersLagZero;
    multi_bivAnalysis             = methodParams.multi_bivAnalysis;
    secondTermCaseVect            = methodParams.secondTermCaseVect;
%     evalEntropyFun                = methodParams.entropyFun;
%     preProcessingFun              = methodParams.preProcessingFun;
    genCondTermFunc               = methodParams.genCondTermFun;
    numNearNei                    = methodParams.numNearNei;
    metric                        = methodParams.metric;
    funcDir                       = methodParams.funcDir;
    homeDir                       = methodParams.homeDir;
    

    numTargets                    = length(idTargets);
    finalCandidatesMtx            = cell(1,numTargets);
    transferEntropy               = zeros(1,numTargets);
    predictiveInfo                = zeros(1,numTargets);
    storageInfo                   = zeros(1,numTargets);
    Tzy                           = zeros(1,numTargets);
    countStruct                   = cell(1,numTargets);
    
    if (max(size(data,1),size(data,2)) == size(data,2))
        data = data';
    end
    
    normData                      = zeros(size(data));

%     seriesToPreprocess            = [idTargets;idDrivers];

    %% STEP 1  | Preprocessing data
    % normalizing data to unitary variance
    numSeries    = min(size(data));
     for m=1:numSeries
         normData(:,m)=(data(:,m)-mean(data(:,m)))/std(data(:,m));
     end

    %% STEP 2  | Final conditional term
    if (~isempty(strfind(func2str(genCondTermFunc),'LagZero')))
        idCandidates                  = genCondTermFunc (infoSeries,idTargets,idDrivers,idOthersLagZero,multi_bivAnalysis,secondTermCaseVect);
    else
        idCandidates                  = genCondTermFunc (infoSeries,idTargets,idDrivers,multi_bivAnalysis,secondTermCaseVect);
    end
%     idCandidates{1,1}

    %% STEP 3  | Evaluating the second conditional entropy term
%     fprintf('\nConditioning Terms Evaluation...');
%     finalCandidatesMtx = nearNeiFirstTermCondEnt(normData,idTargets,idCandidates,methodParams,metric,numNearNei,funcDir,homeDir);
%     fprintf('Done');
    
    for i = 1 : numTargets
        if (strcmp(multi_bivAnalysis,'multiv'))
            if (i==1)
                finalCandidatesMtx{1,i} = nearNeiFirstTermCondEnt(normData,idTargets(1,i),{idCandidates{1,i}},methodParams,metric,numNearNei);
            elseif (i>=2)
                [idIdenticalTar] = find(idTargets(1,1:i-1)==idTargets(1,i));
                if (~isempty(idIdenticalTar))
                    finalCandidatesMtx{1,i}     = finalCandidatesMtx{1,idIdenticalTar(1,1)}(:);
                else
                    finalCandidatesMtx{1,i} = nearNeiFirstTermCondEnt(normData,idTargets(1,i),{idCandidates{1,i}},methodParams,metric,numNearNei);
                end
            end
        else
            finalCandidatesMtx{1,i} = nearNeiFirstTermCondEnt(normData,idTargets(1,i),{idCandidates{1,i}},methodParams,metric,numNearNei);
        end
    end


    parfor i = 1 : numTargets
        if (isempty(finalCandidatesMtx{1,i}))
            transferEntropy(1,i) = 0;
        else
%             [predictiveInfo(1,i),storageInfo(1,i),Tzy(1,i),transferEntropy(1,i),countStruct{1,i}] = PIknn(normData,finalCandidatesMtx{1,i}{1,1},idDrivers(:,i),idTargets(1,i),numNearNei,metric,funcDir,homeDir);
            reducedDrivers       = getRiducedDriv(idDrivers);
            transferEntropy(1,i) = PTEknn(normData,finalCandidatesMtx{1,i}{1,1},reducedDrivers(:,i),idTargets(1,i),numNearNei,metric,funcDir,homeDir);
        end
    end

    %% Step 6  | Returning the output
    output                        = struct;

    output.transferEntropy        = transferEntropy;
    output.finalCandidatesMtx     = finalCandidatesMtx;
%     output.countStruct            = countStruct;%facoltative: useful if
%     you are using PIknn.m function
    output.PI                     = predictiveInfo;
    output.storageInfo            = storageInfo;
    output.tzy                    = Tzy;
    output.params                 = methodParams;


return;