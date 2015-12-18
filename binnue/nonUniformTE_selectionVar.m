function [output] = nonUniformTE_selectionVar(data,methodParams)
% 
% Syntax:
% 
% [output] = nonUniformTransferEntropy(data,methodParams)
% 
% Description:
% 
% 1)  preprocessing the data according to the preprocess function chosen;
% 2)  evaluating the embedding candidates from which the procedure will
%     get the best, final, candidates
% 3)  evaluating the second entropy term according to the non uniform
%     embedding. The step 2 function returns also a cell array containing
%     all the conditional terms for each target
% 4)  evaluating the first conditional entropy term. Fist it has to be
%     checked if the user wants to include the present of certain series
%     too;
% 5)  evaluating the transfer entropy, for each target, as the difference
%     between the two conditional entropy terms;
% 6)  storing the most interesting outcomes, returning them in the output
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
    numTargets                    = length(idTargets);
    multi_bivAnalysis             = methodParams.multi_bivAnalysis;
    secondTermCaseVect            = methodParams.secondTermCaseVect;
    evalEntropyFun                = methodParams.entropyFun;
    preProcessingFun              = methodParams.preProcessingFun;
    genCondTermFunc               = methodParams.genCondTermFun;
    ndmax                         = methodParams.ndmax;
    order                         = methodParams.order;
    choiceCriterionFun            = methodParams.choiceCriterionFun;
    partialCondTh                 = methodParams.partialCondTh;
    defaultReducedVar             = methodParams.defaultReducedVar;
    
    
    secondEntropyTerm             = zeros(1,numTargets);
    minEntropies                  = cell(1,numTargets);
    finalCandidatesMtx            = cell(1,numTargets);
    condMutualInfo                = cell(1,numTargets);
    threshold                     = cell(1,numTargets);

    if (max(size(data,1),size(data,2)) == size(data,1))
        data = data';
    end

    seriesToPreprocess            = [idTargets;idDrivers];

    %% STEP 1  | Preprocessing data
    dataPreprocessed              = preProcessingFun(data,seriesToPreprocess,multi_bivAnalysis,methodParams);
    
    %% Intermediate Step to choose the most informative variables for each set of drivers
    % the function returns the id series most informative for each driver,
    % we need to choose only few of them according to a certain criterion
    [y ind] = init_partial_conditioning_par(data',ndmax,order);
    % pointer to the function apt to choose the correct number of
    % informative series being careful to not choose the target series
    [m] = choiceCriterionFun(y,ind,partialCondTh,defaultReducedVar);
    
    
    %% STEP 2  | Final conditional term
    idCandidates                  = genCondTermFunc (infoSeries,idTargets,idDrivers,multi_bivAnalysis,secondTermCaseVect,m);


    %% STEP 3  | Evaluating the second conditional entropy term
%     fprintf('\nSecond Conditional Entropy Term Evaluation...');
    for i = 1 : numTargets
        if (strcmp(multi_bivAnalysis,'multiv'))
%             if (i==1)
                [secondEntropyTerm(1,i),minEntropies{1,i},finalCandidatesMtx{1,i},condMutualInfo{1,i},threshold{1,i}] = evalEntropyFun(dataPreprocessed,idTargets(1,i),idCandidates(:,i),methodParams);
%             elseif (i>=2)
%                 [idIdenticalTar] = find(idTargets(1,1:i-1)==idTargets(1,i));
%                 if (~isempty(idIdenticalTar))
%                     secondEntropyTerm(1,i)      = secondEntropyTerm(1,idIdenticalTar(1,length(idIdenticalTar)));
%                     minEntropies{1,i}           = minEntropies{1,idIdenticalTar(1,1)};
%                     finalCandidatesMtx{1,i}     = finalCandidatesMtx{1,idIdenticalTar(1,1)}(:);
%                     condMutualInfo{1,i}         = condMutualInfo{1,idIdenticalTar(1,1)};
%                     threshold{1,i}              = threshold{1,idIdenticalTar(1,1)};
%                 else
%                     [secondEntropyTerm(1,i),minEntropies{1,i},finalCandidatesMtx{1,i},condMutualInfo{1,i},threshold{1,i}] = evalEntropyFun(dataPreprocessed,idTargets(1,i),idCandidates(:,i),methodParams);
%                 end
%             end
        else
            [secondEntropyTerm(1,i),minEntropies{1,i},finalCandidatesMtx{1,i},condMutualInfo{1,i},threshold{1,i}] = evalEntropyFun(dataPreprocessed,idTargets(1,i),idCandidates(:,i),methodParams);
        end
    end
%     fprintf('Done');


    %% STEP 4  | Evaluating the first conditional entropy term
%     fprintf('\n\nFirst Conditional Entropy Term Evaluation...');
    if (methodParams.usePresent == 0)
        firstEntropyTerm       = evaluateNonUniformEntropy2(dataPreprocessed,idTargets,idDrivers,finalCandidatesMtx,secondEntropyTerm,minEntropies,methodParams);
    else
    %     If the user wants to use the present the idDrivers matrix is set with
    %     a redundant number of the same ids. getReducedDriv returns the
    %     idDrivers taken once
        reducedDrivers         = getRiducedDriv(idDrivers);
        firstEntropyTerm       = evaluateNonUniformEntropy2(dataPreprocessed,idTargets,reducedDrivers,finalCandidatesMtx,secondEntropyTerm,minEntropies,methodParams);
    end
%     fprintf('Done\n');


    %% Step 5  | Evaluating transfer entropy
    transferEntropy               = firstEntropyTerm - secondEntropyTerm;


    %% Step 6  | Returning the output
    output                        = struct;

    output.firstEntropy           = firstEntropyTerm;
    output.secondEntropy          = secondEntropyTerm;
    output.transferEntropy        = transferEntropy;
    output.finalCandidatesMtx     = finalCandidatesMtx;
    output.minEntropies           = minEntropies;
    output.condMutualInfo         = condMutualInfo;
    output.threshold              = threshold;
    output.params                 = methodParams;
    output.partianlCondVar        = y;
    output.selectedVar            = m;

return;