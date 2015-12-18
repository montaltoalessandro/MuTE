function [idCandidates] = generateConditionalTerm (infoSeries,idTargets,idDrivers,multi_uniAnalysis,holdCandidates)
% 
% Syntax:
% 
% [idCandidates] = generateCandidates (infoSeries,idTargets,idDrivers,multi_uniAnalysis,caseVect)
% 
% 
% Description:
% 
% the function generates the candidate terms according to the infoSeries,
% idTargets and idDrivers matrices. The user can choose to perform a
% multivariate or bivariate analysis according to the multi_bivAnalysis
% field. It can be chosen also to evaluate the candidates according to the
% caseVect field
% 
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
% holdCandidates          : logical vector of dimensions 1 x 2: the first
%                           position points to idTargets, the second one 
%                           points to idDrivers. Please set 1 if you want
%                           to include those id in your idCandidates
% Example:
% 
% holdCandidates          : [0 1]        means the user wants to include
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
                
%             getting the id of the variables except the idTargets and
%             idDrivers
            otherVarCandidates            = getOtherVarCandidates(infoSeries,idTargets,idDrivers);
            
            if (holdCandidates(1,1) == 1)
%                 getting target candidates
               targetCandidates           = getTargetCandidates(infoSeries,idTargets);
               if (holdCandidates(1,2) == 1)
%                    getting driver candidates
                   driversCandidates      = getDriversCandidates(infoSeries,idDrivers);
%                    unifying otherVar, targets and drivers
                   idCandidates           = unifyCandidates(numTargets,targetCandidates,driversCandidates,otherVarCandidates);
               else
%                    unifying otherVar and targets
                   idCandidates           = unifyCandidates(numTargets,targetCandidates,otherVarCandidates);
               end
            else
               if (holdCandidates(1,2) == 1)
%                    getting driver candidates
                   driversCandidates      = getDriversCandidates(infoSeries,idDrivers);
%                    unifying otherVar and drivers
                   idCandidates           = unifyCandidates(numTargets,driversCandidates,otherVarCandidates);
               else
%                    returning other variables id only
                   idCandidates           = otherVarCandidates;
               end

            end
            
        case 'biv'
            
            if (holdCandidates(1,1) == 1)
%                 getting target candidates
               targetCandidates           = getTargetCandidates(infoSeries,idTargets);
               if (holdCandidates(1,2) == 1)
%                    getting driver candidates
                   driversCandidates      = getDriversCandidates(infoSeries,idDrivers);
%                    unifying targets and drivers
                   idCandidates           = unifyCandidates(numTargets,targetCandidates,driversCandidates);
               else
%                    returning targets only
                   idCandidates           = targetCandidates;
               end

            else
               if (holdCandidates(1,2) == 1)
%                    returning drivers only
                   idCandidates      = getDriversCandidates(infoSeries,idDrivers);
               else
%                    returning null structure
                   idCandidates               = [];
               end
            end
            
    end



return;