function learnParams=setLearnParams(learnParams, varargin)
%Parameters:    derivActFunctions   : cellarray of function pointers
%               trainSet            : nxd matrix
%               trainTarget         : nxc matrix 
%               validSet            : mxd matrix
%               validTarget         : mxc matrix 
%               maxEpochs           : scalar
%               lambda              : scalar
%               learningType        : string ('batch','online')
%               useValidation       : boolean 
%               eta                 : scalar
%               eta0                : scalar
%               alpha               : scalar
%               sigmaU              : scalar for paddle
%               tau                 : scalar for paddle
%               numComps            : scalar for paddle
%               lambdaAddedErr      : scalar
%               step                : scalar for the stop condition
%               soglia              : scalar for the stop condition
%               spSoglia            : scalar for the sparsity condition
%               learningAlgorithm   : function pointer
%               numLineSearch       : scalar
%               derivSparsityFunc   : function pointer, ex. @derivSparseLog
%               errorFunction       : function pointer, ex. @SQError 
%               derivErrorFunction  : function pointer, ex. @derSQError
%               deltaW              : cell array, weigth variations 
%               batch               : boolean value
%               sparse              : boolean value
%                                     if sparse = 1 -> sparsityFunction(hidden input)
%                                     if sparse = 2 -> sparsityFunction(hidden output)
%               derivSparsityFunc   : function pointer 
%               deltaRBP            : cell array, delta value for resilient
%                                     back-propagation
%               prevGrad            : cella array, previous gradient
%               RBPParam            : a struct containing RBP parameters
%               wLayersToBeUpdated  : a index vector containing the weight
%                                     layer indexes to be updated, ex. [1 3
%                                     5]
%               explicitGradErrFun  : function pointer
%               addedErrorTerm      : matrix
%               dictionarySparsity  : boolean value
%                                     if dictionarySparsity = 'proj'  ->
%                                     sparsity imposed on the projection
%                                     dictionary only
%                                     if dictionarySparsity = 'recon' ->
%                                     sparsity imposed on the
%                                     reconstruction dictionary only
%                                     if dictionarySparsity = 'all'   ->
%                                     sparsity imposed on all the
%                                     dictionaries
PARAMS={'derivErrorFunction' 'errorFunction' 'derivActFunctions' 'trainSet' 'trainTarget' 'validSet' ...
        'validTarget' 'maxEpochs' 'lambda' 'learningType' 'useValidation' ...
        'eta' 'learningAlgorithm' 'numLineSearch' 'derivSparsityFunc' 'learningType' 'eta0' ...
        'deltaW' 'alpha' 'sigmaU' 'tau' 'numComps' 'batch' 'sparse' 'derivSparsityFunc' 'deltaRBP' 'deltaRBP' 'RBPParam' 'kernelsNumber'...
        'wLayersToBeUpdated' 'weightAndBiasUpdate' 'inputUpdate' 'explicitGradErrFun' 'addedErrorTerm'...
        'lambdaAddedErr' 'step' 'soglia' 'spSoglia' 'dictionarySparsity'};
LEN=length(PARAMS);
if isstruct(learnParams)
    len=length(varargin);
    for i=1:2:len-1
        if ischar(varargin{i})
            isparam=0;
            for k=1:LEN
                if strcmp(varargin{i},PARAMS{k})
                    isparam=1;
                end
            end
            if isparam==1
                learnParams.(varargin{i})=varargin{i+1};
            end
        end
    end
end