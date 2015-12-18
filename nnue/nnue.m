function [output] = nnue(data,methodParams)
% 
% Syntax:
% 
% [output] = binTransferEntropy(data,methodParams)
% 
% Description:
% 
% 1)  preprocessing the data according to the preprocess function chosen;
% 2)  evaluating the series terms involved to build the matrix containing
%     all the shifted series to evaluate the first conditional entropy 
%     term;
% 3)  evaluating the first conditional entropy term;
% 4)  evaluating the series terms involved to build the matrix containing
%     all the shifted series to evaluate the second conditional entropy 
%     term;
% 5)  evaluating the second conditional entropy term;
% 6)  evaluating the transfer entropy, for each target, as the difference
%     between the two conditional entropy terms;
% 8)  storing the most interesting outcomes, returning them in the output
%     structure
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
    firstTermCaseVect             = methodParams.firstTermCaseVect;
%     secondTermCaseVect            = methodParams.secondTermCaseVect;
%     evalEntropyFun                = methodParams.entropyFun;
    genCondTermFunc               = methodParams.genCondTermFun;
%     modelOrder                    = methodParams.modelOrder;
    numNearNei                    = methodParams.numNearNei;
    metric                        = methodParams.metric;
    funcDir                       = methodParams.funcDir;
    homeDir                       = methodParams.homeDir;
    

%     numSeries                     = size(infoSeries,1);
%     infoSeries(:,2)               = ones(numSeries,1).*modelOrder;
%     indices                       = (1:size(data,2));
    numTargets                    = length(idTargets);
    transferEntropy               = zeros(1,numTargets);
    predictiveInfo                = zeros(1,numTargets);
    storageInfo                   = zeros(1,numTargets);
    Tzy                           = zeros(1,numTargets);
    countStruct                   = cell(1,numTargets);
    
    if (max(size(data,1),size(data,2)) == size(data,2))
        data = data';
    end
    
    normData                      = zeros(size(data));

    %% STEP 1  | Preprocessing data
    % normalizing data to unitary variance
    numSeries    = min(size(data));
     for m=1:numSeries
         normData(:,m)=(data(:,m)-mean(data(:,m)))/std(data(:,m));
     end
     
    cd(funcDir);
    
    if (~isempty(strfind(func2str(genCondTermFunc),'LagZero')))
        generalIdConditionalTerm        = genCondTermFunc(infoSeries,idTargets,idDrivers,idOthersLagZero,multi_bivAnalysis,firstTermCaseVect);
    else
        generalIdConditionalTerm        = genCondTermFunc(infoSeries,idTargets,idDrivers,multi_bivAnalysis,firstTermCaseVect);
    end
    
    for i = 1 : numTargets%parfor
        if (isempty(generalIdConditionalTerm{1,i}))
            transferEntropy(1,i) = 0;
        else
            reducedDrivers                = getRiducedDriv(idDrivers);
            transferEntropy(1,i) = PTEknn(normData,generalIdConditionalTerm{1,i},reducedDrivers(:,i),idTargets(1,i),numNearNei,metric,funcDir,homeDir);
        end
    end


    %% Step 7  | 
    threshold                 = evalThresholdNearNeighbour(normData,idTargets,idDrivers,generalIdConditionalTerm,methodParams,numNearNei,metric,funcDir,homeDir);

    cd(homeDir);
    
    %% Step 8  | Returning the output
    output                        = struct;

    output.transferEntropy        = transferEntropy;
    output.testThreshold          = threshold;
%     output.countStruct            = countStruct;
    output.PI                     = predictiveInfo;
    output.storageInfo            = storageInfo;
    output.tzy                    = Tzy;
    output.params                 = methodParams;


return;