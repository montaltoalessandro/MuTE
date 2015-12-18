function [output] = binue(data,methodParams)
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
    secondTermCaseVect            = methodParams.secondTermCaseVect;
    evalEntropyFun                = methodParams.entropyFun;
    preProcessingFun              = methodParams.preProcessingFun;
    genCondTermFunc               = methodParams.genCondTermFun;
    numSurrogates                 = methodParams.numSurrogates;
%     modelOrder                    = methodParams.modelOrder;

    if (max(size(data,1),size(data,2)) == size(data,1))
        data = data';
    end

    seriesToPreprocess            = [idTargets;idDrivers];

    %% STEP 1  | Preprocessing data
    dataPreprocessed              = preProcessingFun(data,seriesToPreprocess,multi_bivAnalysis,methodParams);


    %% STEP 2  | First Id Conditional Terms  | Targets (+ Other Variables if multi_bivAnalysis = 'multiv')
    if (~isempty(strfind(func2str(genCondTermFunc),'LagZero')))
        firstIdConditionalTerm        = genCondTermFunc(infoSeries,idTargets,idDrivers,idOthersLagZero,multi_bivAnalysis,firstTermCaseVect);
    else
        firstIdConditionalTerm        = genCondTermFunc(infoSeries,idTargets,idDrivers,multi_bivAnalysis,firstTermCaseVect);
    end


    %% STEP 3  | Evaluating the first conditional entropy term
%     fprintf('\n\nFirst Conditional Entropy Term Evaluation...');
    firstEntropyTerm              = evalEntropyFun(dataPreprocessed,idTargets,firstIdConditionalTerm);
%     fprintf('Done\n');


    %% Step 4  | Second Id Conditional Terms  | Target + Drivers (+ Other Variables if multi_bivAnalysis = 'multiv')
    if (~isempty(strfind(func2str(genCondTermFunc),'LagZero')))
        secondIdConditionalTerm       = genCondTermFunc(infoSeries,idTargets,idDrivers,idOthersLagZero,multi_bivAnalysis,secondTermCaseVect);
    else
        secondIdConditionalTerm       = genCondTermFunc(infoSeries,idTargets,idDrivers,multi_bivAnalysis,secondTermCaseVect);
    end


    %% Step 5  | Evaluating the second conditional entropy term
%     fprintf('\nSecond Conditional Entropy Term Evaluation...');
    secondEntropyTerm             = evalEntropyFun(dataPreprocessed,idTargets,secondIdConditionalTerm);
%     fprintf('Done\n');


    %% Step 6  | Evaluating transfer entropy
    transferEntropy           = firstEntropyTerm - secondEntropyTerm;
    
    %% Step 7  | 
    threshold                 = evalBinTransferEntropySurrogates(dataPreprocessed,idTargets,idDrivers,secondIdConditionalTerm,methodParams,numSurrogates,firstEntropyTerm);

    %% Step 8  | Returning the output
    output                    = struct;

    output.firstEntropy       = firstEntropyTerm;
    output.secondEntropy      = secondEntropyTerm;
    output.transferEntropy    = transferEntropy;
    output.testThreshold      = threshold;
    output.params             = methodParams;


return;