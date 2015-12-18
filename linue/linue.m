function [output] = linue(data,methodParams)
% 
% Syntax:
% 
% [output] = linearTransferEntropy(data,methodParams)
% 
% Description:
% 
% 1)  evaluating the series terms involved to build the matrix containing
%     all the shifted series to evaluate the first conditional entropy 
%     term;
% 2)  evaluating the first conditional entropy term;
% 3)  evaluating the series terms involved to build the matrix containing
%     all the shifted series to evaluate the second conditional entropy 
%     term;
% 4)  evaluating the second conditional entropy term;
% 5)  evaluating the transfer entropy, for each target, as the difference
%     between the two conditional entropy terms;
% 6)  
% 7)  storing the most interesting outcomes, returning them in the output
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
    genCondTermFunc               = methodParams.genCondTermFun;
    
    if (max(size(data,1),size(data,2)) == size(data,1))
        data = data';
    end
    
    dataPreprocessed                      = zeros(size(data));
    numSeries    = min(size(data));
    for m=1:numSeries
        dataPreprocessed(m,:) = data(m,:)-mean(data(m,:));
    end

    if (isfield(methodParams,'minOrder') || isfield(methodParams,'maxOrder'))
        [w, A, C, sbc, fpe, th]                 = arfit(data', methodParams.minOrder, methodParams.maxOrder);
        if (isfield(methodParams,'orderCriterion') && strcmp(methodParams.orderCriterion,'bayesian'))
            [tmpMinOrder,idTmpMinOrder]             = min(sbc);
        else
            [tmpMinOrder,idTmpMinOrder]             = min(fpe);
        end
        bestOrder                               = methodParams.minOrder + idTmpMinOrder - 1;
        numSeries                               = size(infoSeries,1);
        infoSeries(:,2)                         = ones(numSeries,1).*bestOrder;                          
    end
    
    %% STEP 1  | First Id Conditional Terms  | Targets (+ Other Variables if multi_bivAnalysis = 'multiv')
    if (~isempty(strfind(func2str(genCondTermFunc),'LagZero')))
        firstIdConditionalTerm                               = genCondTermFunc(infoSeries,idTargets,idDrivers,idOthersLagZero,multi_bivAnalysis,firstTermCaseVect);
    else
        firstIdConditionalTerm                               = genCondTermFunc(infoSeries,idTargets,idDrivers,multi_bivAnalysis,firstTermCaseVect);
    end
    
    
    %% STEP 2  | Evaluating the first conditional entropy term
%     fprintf('\n\nFirst Conditional Entropy Term Evaluation...');
    [firstEntropyTerm,reconstructionError1]              = evalEntropyFun(dataPreprocessed,idTargets,firstIdConditionalTerm);
%     fprintf('Done\n');

    
    %% Step 3  | Second Id Conditional Terms  | Target + Drivers (+ Other Variables if multi_bivAnalysis = 'multiv')
    if (~isempty(strfind(func2str(genCondTermFunc),'LagZero')))
        secondIdConditionalTerm                              = genCondTermFunc(infoSeries,idTargets,idDrivers,idOthersLagZero,multi_bivAnalysis,secondTermCaseVect);
    else
        secondIdConditionalTerm                              = genCondTermFunc(infoSeries,idTargets,idDrivers,multi_bivAnalysis,secondTermCaseVect);
    end


    %% Step 4  | Evaluating the second conditional entropy term
%     fprintf('\nSecond Conditional Entropy Term Evaluation...');
    [secondEntropyTerm,reconstructionError2]             = evalEntropyFun(dataPreprocessed,idTargets,secondIdConditionalTerm);
%     fprintf('Done\n');


    %% Step 5  | Evaluating transfer entropy
    transferEntropy                                      = firstEntropyTerm - secondEntropyTerm;

    
    %% Step 6  | Evaluating transfer entropy
    pValue                                               = fTest(firstIdConditionalTerm,secondIdConditionalTerm,reconstructionError1,reconstructionError2);
    
    %% Step 7  | Returning the output
    output                    = struct;

    output.firstEntropy       = firstEntropyTerm;
    output.secondEntropy      = secondEntropyTerm;
    output.transferEntropy    = transferEntropy;
    output.pValue             = pValue;
    output.bestOrder          = bestOrder;
    output.params             = methodParams;




return;