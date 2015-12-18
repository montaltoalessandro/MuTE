function [paramsLinearTransferEntropy] = createLinueParams(varargin)
% 
% Syntax:
% 
% [paramsBinTransferEntropy] = createBinTransferEntropyParams(numSeries)
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
%                                          column
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

numSeries                                         = varargin{1,1};
paramsLinearTransferEntropy                       = struct;

paramsLinearTransferEntropy.idTargets             = varargin{1,2};
paramsLinearTransferEntropy.idDrivers             = varargin{1,3};
paramsLinearTransferEntropy.idOthersLagZero       = varargin{1,4};
paramsLinearTransferEntropy.modelOrder            = varargin{1,5};
paramsLinearTransferEntropy.infoSeries            = [(1:numSeries)' , ones(numSeries,1).*paramsLinearTransferEntropy.modelOrder , ones(numSeries,2)];
paramsLinearTransferEntropy.multi_bivAnalysis     = varargin{1,6};
paramsLinearTransferEntropy.minOrder              = varargin{1,7};
paramsLinearTransferEntropy.maxOrder              = varargin{1,8};
paramsLinearTransferEntropy.orderCriterion        = varargin{1,9};
paramsLinearTransferEntropy.entropyFun            = varargin{1,10};
paramsLinearTransferEntropy.firstTermCaseVect     = varargin{1,11};
paramsLinearTransferEntropy.secondTermCaseVect    = varargin{1,12};
% ******** Set the following fields together *******
paramsLinearTransferEntropy.genCondTermFun        = varargin{1,13};
paramsLinearTransferEntropy.usePresent            = varargin{1,14};
% **************************************************


return;