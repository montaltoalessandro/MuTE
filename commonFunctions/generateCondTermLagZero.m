function [idCandidates] = generateCondTermLagZero (infoSeries,idTargets,idDrivers,idOthersLagZero,multi_uniAnalysis,holdCandidates)
% Syntax:
% 
% [idCandidates] = generateCandidates (infoSeries,idTargets,idDrivers,caseVect,multi_uniAnalysis)
% 
% --------------------
% 
% Description:
% 
% the function generates the element sequence according to the infoSeries,
% idTargets and idDrivers matrices. The user can choose to perform a
% multivariate or univariate analysis setting the 'multi_uniAnalysis' as
% 
% - multi_uniAnalysis     = 'biv';       in that case just idTargets and
%                                        idDrivers will be considered
% 
% - multi_uniAnalysis     = 'multiv';    in that case idTarget, idDrivers
%                                        and all the other variables will
%                                        be considered
% 
% holdCandidates          = logical vector of dimensions 1 x 2: the first
%                           position points to idTargets, the second one 
%                           points to idDrivers. Please set 1 if you want
%                           to include those id in your idCandidates
% Example:
% 
% caseVect                = [0 1];       it means the user wants to include
%                                        idDrivers only in the idCandidates
% Input:
% 
% infoSeries              : matrix containing id of all series and, for
%                           each series, on the same row, maximum model
%                           order 'p', lag 'lag', delay 'del' and 
%                           flag to use its present
% 
% idTargets               : row vector contanining the indeces of the 
%                           series you want to study as target series
% 
% idDrivers               : matrix containing, in each column, the indeces 
%                           of the series chosen as drivers for the
%                           target in the corresponding column
% 
% multi_bivAnalysis       : field to perform a multivariate
%                           or bivariate analysis
% 
% caseVect                : logical vector of dimensions 1 x 2: the first
%                           position points to idTargets, the second one 
%                           points to idDrivers. Please set 1 if you want
%                           to include those id in your idCandidates
% Example:
% 
% caseVect                : [0 1]        means the user wants to include
%                                        idDrivers only in the idCandidates
% 
% Output:
% 
% idCandidates            : returns a cell array containing the id
%                           candidates for each id target
% 
% Calling function        : the function is called when the generation of
%                           the conditionl terms is required, therefore
%                           after the preprocessing step and before the
%                           entropy evaluation
% Example:
% 
% binTransferEntropy ; nonUniformTransferEntropy

numTargets              = size(idTargets,2);

    switch multi_uniAnalysis
        case 'multiv'
            
            reducedDrivers                = getRiducedDriv(idDrivers);
            otherVarCandidates            = getOtherVarCandidatesLagZero(infoSeries,idTargets,reducedDrivers,idOthersLagZero);
            
            if (holdCandidates(1,1) == 1)
               targetCandidates           = getTargetCandidates(infoSeries,idTargets);
               if (holdCandidates(1,2) == 1)
                   driversCandidates      = getDrivCandidatesLagZero(infoSeries,idDrivers);
%                    unifying otherVar, targets and drivers
                   idCandidates           = unifyCandidates(numTargets,targetCandidates,driversCandidates,otherVarCandidates);
               else
%                    unifying otherVar and targets
                   idCandidates           = unifyCandidates(numTargets,targetCandidates,otherVarCandidates);
               end
            else
               if (holdCandidates(1,2) == 1)
                   driversCandidates      = getDrivCandidatesLagZero(infoSeries,idDrivers);
%                    unifying otherVar and drivers
                   idCandidates           = unifyCandidates(numTargets,driversCandidates,otherVarCandidates);
               else
                   idCandidates           = otherVarCandidates;
               end

            end
            
            
            
        case 'biv'
            
            if (holdCandidates(1,1) == 1)
               targetCandidates           = getTargetCandidates(infoSeries,idTargets);
               if (holdCandidates(1,2) == 1)
                   driversCandidates      = getDrivCandidatesLagZero(infoSeries,idDrivers);
%                    unifying targets and drivers
                   idCandidates           = unifyCandidates(numTargets,targetCandidates,driversCandidates);
               else
                   idCandidates           = targetCandidates;
               end

            else
               if (holdCandidates(1,2) == 1)
%                    returning drivers only
                   idCandidates      = getDrivCandidatesLagZero(infoSeries,idDrivers);
               else
                   idCandidates               = [];
               end
            end
            
    end



return;