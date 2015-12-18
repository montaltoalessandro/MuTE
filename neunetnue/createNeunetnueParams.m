function [paramsNonUniNeuralNet] = createNeunetnueParams(varargin)
% 
% Syntax:
% 
% [paramsNonUniformTransferEntropy] = createNonUniformTransferEntropyParams(numSeries)
% 
% Description:
% 
% every method has got its own parameters. Please set a structure as
% follows:
% 
% paramsMethodName                      = struct;
% 
% ******** NECESSARY FIELD ************
% 
% 1)
% 
% paramsMethodName.infoSeries           = for each series please set its
%                                         own: maximum model order 'p',
%                                         lag 'lag', delay 'del' and flag 
%                                         to use its present in a 
%                                         multivariate anlysis when the 
%                                         series is not a target or a 
%                                         driver, as in the following 
%                                         example
% 
%                 ---  --- --- --- ---
%                 |1 | |4 ||1 ||1 ||-1|
%                 |2 | |3 ||2 ||3 ||-1|
%                 |. | |. ||. ||. ||-1|
%                 |. | |. ||. ||. ||-1|
%                 |. | |. ||. ||. ||-1|
%                 |--| |--||--||--||-1|
%                  /\   /\  /\  /\  /\
%                  ||   ||  ||  ||  ||
%       Series Number   p  lag  del flag for the present influence
% 
% N.B. = if you want to use an estimator for your 'p', 'lag' and 'del'
% please specify a pointer to function that returns a matrix as the example
% above. For instance:
% 
% create the variables for generateVarTargetDriversFunc
% 
% paramsMethodName.varTargetDrivers      = @generateVarTargetDriversFunc(data, variables)
% 
% 2)
% 
% paramsMethodName.idTargets             = row vector contanining the
%                                          indeces of the series you want
%                                          to study as target series
% Example:
% 
% paramsMethodName.idTargets             = [1 3];
% 
% 3)
% 
% paramsMethodName.idDrivers             = matrix containing, in each 
%                                          column, the indeces of the 
%                                          series chosen as drivers for the
%                                          target in the corresponding
%                                          column. Note that if you include
%                                          two times an id means you want
%                                          to use the present of that
%                                          driver
% Example 1:
% 
% paramsMethodName.idDrivers             = [2 3 4;1 2 3]'; in this way the
%                                          rows 2 3 4 are the drivers of
%                                          the target 1 and the rows 1 2 3
%                                          are the drivers of the target 3.
%                                          If you want to set a different
%                                          number of drivers per target,
%                                          please replace the driver id
%                                          with 0 entry
% Example 2:
% 
% paramsMethodName.idDrivers             = [2 3 4;1 2 0]'; in this way the
%                                          rows 2 3 4 are the drivers of
%                                          the target 1 and only the rows
%                                          1 2 are the drivers of the 
%                                          target 3.
% 
% Example 3:
% 
% paramsMethodName.idDrivers             = [2 2 4;1 1 0]'; in this way the
%                                          row 2 is considered with its
%                                          present
% 
% paramsMethodName.multi_bivAnalysis     = field to perform a multivariate
%                                          or bivariate analysis
% Example:
% 
% - multi_uniAnalysis     = 'biv';       in that case just idTargets and
%                                        idDrivers will be considered
% 
% - multi_uniAnalysis     = 'multiv';    in that case idTarget, idDrivers
%                                        and all the other variables will
%                                        be considered
% 
% **************************************
% paramsMethodName.nameField            = ...   ;

numSeries                                    = varargin{1,1};
paramsNonUniNeuralNet                        = struct;

paramsNonUniNeuralNet.idTargets              = varargin{1,2};%[ones(1,18) ones(1,18)*2 ones(1,18)*3 ones(1,18)*4 ones(1,18)*5 ones(1,18)*6 ones(1,18)*7 ones(1,18)*8 ones(1,18)*9 ones(1,18)*10 ones(1,18)*11 ones(1,18)*12 ones(1,18)*13 ones(1,18)*14 ones(1,18)*15 ones(1,18)*16 ones(1,18)*17 ones(1,18)*18 ones(1,18)*19];%[ones(1,3) ones(1,3)*2 ones(1,3)*3 ones(1,3)*4]
paramsNonUniNeuralNet.idDrivers              = varargin{1,3};%[[2:19] [1 3:19] [1:2 4:19] [1:3 5:19] [1:4 6:19] [1:5 7:19] [1:6 8:19] [1:7 9:19] [1:8 10:19] [1:9 11:19] [1:10 12:19] [1:11 13:19] [1:12 14:19] [1:13 15:19] [1:14 16:19] [1:15 17:19] [1:16 18:19] [1:17 19] [1:18]];%[2 3 4 1 3 4 1 2 4 1 2 3]
paramsNonUniNeuralNet.idOthersLagZero        = varargin{1,4};
paramsNonUniNeuralNet.modelOrder             = varargin{1,5};
paramsNonUniNeuralNet.infoSeries             = [(1:numSeries)' , ones(numSeries,1).*paramsNonUniNeuralNet.modelOrder , ones(numSeries,2)];
paramsNonUniNeuralNet.firstTermCaseVect      = varargin{1,6};
paramsNonUniNeuralNet.secondTermCaseVect     = varargin{1,7};
paramsNonUniNeuralNet.multi_bivAnalysis      = varargin{1,8};
paramsNonUniNeuralNet.eta                    = varargin{1,9};
paramsNonUniNeuralNet.alpha                  = varargin{1,10};
paramsNonUniNeuralNet.actFunc                = varargin{1,11};
paramsNonUniNeuralNet.numEpochs              = varargin{1,12};
paramsNonUniNeuralNet.bias                   = varargin{1,13};
paramsNonUniNeuralNet.epochs                 = varargin{1,14};
paramsNonUniNeuralNet.threshold              = varargin{1,15};
paramsNonUniNeuralNet.dividingPoint          = varargin{1,16};
paramsNonUniNeuralNet.valStep                = varargin{1,17};
paramsNonUniNeuralNet.valThreshold           = varargin{1,18};
paramsNonUniNeuralNet.learnAlg               = varargin{1,19};
paramsNonUniNeuralNet.rbpIncrease            = varargin{1,20};
paramsNonUniNeuralNet.rbpDecrease            = varargin{1,21};
paramsNonUniNeuralNet.rangeW                 = varargin{1,22};
paramsNonUniNeuralNet.coeffHidNodes          = varargin{1,23};
% ******** Set the following fields together *******
paramsNonUniNeuralNet.genCondTermFun         = varargin{1,24};
paramsNonUniNeuralNet.usePresent             = varargin{1,25};
% **************************************************

return;