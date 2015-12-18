function [varargout]=computeGradient(ffwNet, learnParams,varargin)
%function [derW derB derI]=computeGradient(ffwNet, learnParams,pointIndexes)
%INPUT:   ffwNet                :   struct variable storing a feed forward
%                                   network. See 'createFfw' function.
%         learnParams           :   struct variable storing parameters for
%                                   learning or other things. See
%                                   'createLearnParams function'.
% Moreover, it admits parameter/value pairs to specify additional properties. 
%         'pointIndexes'        :  (Optional) Array variable storing the
%                                   indexes of the dataset points involved in
%                                   the gradient computation. The default
%                                   corresponds to consider all the
%                                   dataset.
%         'compWeightGradient'  : boolean value. True value allows to compute the
%                                 weight and bias gradient. The default is true.
%
%         'compInputGradient'  : boolean value. True value allows to compute the
%                                 input gradient. The default is false.         
%OUTPUT:  
%         It returns one of the followings output: 
%                           1) the pair derW,derB 
%                           2) the triple derW,derB,derI
%                           3) derI only. 
% Whith
%         derW              :   Cell array storing the weight gradient. 
%                               The n-element is a matrix corresponding to 
%                               the derivatives of the n-th weight layer  
%         derB              :   Cell array storing the bias gradient. 
%                               The n-element is an array corresponding to 
%                               the gradient of the n-th bias layer
%         derI              :   Nxd array storing the input gradient. The
%                               n-th element refers to n-th input.
%EXAMPLES:
% [derW derB]=computeGradient(ffwNet, learnParams);
% [derI]=computeGradient(ffwNet, learnParams,'compInputGradient',1,'compWeightGradient',0);
% [derW derB derI]=computeGradient(ffwNet, learnParams,'compInputGradient',1);
% [derW derB]=computeGradient(ffwNet, learnParams,'pointIndexes',1);
%nout = max(nargout,1);
        
        
useBias            = ffwNet.useBias;
if isfield(learnParams,'sparse') 
    sparse=learnParams.sparse;
else
    sparse=0;
end
[compWeightGradient,compInputGradient,pointIndexes]= initP(varargin);
if isempty(pointIndexes)
    trainSet=learnParams.trainSet;
    trainTarget=learnParams.trainTarget;
else
    trainSet=learnParams.trainSet(pointIndexes,:);
    trainTarget=learnParams.trainTarget(pointIndexes,:);
end
% N=size(trainSet,1);
numOfWeightLayer   = ffwNet.numOfweightLayers;
derivErrorFunction = learnParams.derivErrorFunction;
derivActFunctions  = learnParams.derivActFunctions;
delta              = cell(1,numOfWeightLayer);
derW               = cell(1,numOfWeightLayer);
derB               = cell(1,numOfWeightLayer);
%derI               = zeros(N,ffwNet.numNodesForLayers(1));


    
%Forward step
[layerOutput,layerInput]=ffwForwardStep(ffwNet, trainSet);

%Computing output delta
delta{numOfWeightLayer} = derivErrorFunction(layerOutput{numOfWeightLayer},trainTarget);
delta{numOfWeightLayer} = derivActFunctions{numOfWeightLayer}(layerInput{numOfWeightLayer}) .* delta{numOfWeightLayer};

%Computing hidden delta
delta = computingHiddenDelta(delta,layerInput,numOfWeightLayer,derivActFunctions,sparse,ffwNet,learnParams);


%Computing weight and bias gradient
nOut=1;
if compWeightGradient
    
    derW{1} = delta{1}' * trainSet;
    [derW,derB]=computingWeightAndBiasGradient(derW, derB, layerOutput, ffwNet,delta,useBias);
    if (isfield(learnParams,'explicitGradErrFun') && ~isempty(learnParams.explicitGradErrFun))
      [derW_2,derB_2]=learnParams.explicitGradErrFun(ffwNet,learnParams);
      for i=1:length(derW)
        derW{i}=derW{i}+derW_2{i};
        derB{i}=derB{i}+derB_2{i};
      end
    end
    varargout{nOut} = derW;
    varargout{nOut+1} = derB;
    nOut=nOut+2;
end
%compute input gradient
if compInputGradient
    derI = delta{1} * ffwNet.W{1};
    if (isfield(learnParams,'explicitGradErrFun')&& ~isempty(learnParams.explicitGradErrFun))
      derI_2=learnParams.explicitGradErrFun(ffwNet,learnParams);
      derI=derI+derI_2;
    end
    varargout{nOut} = derI;
end
return;

function delta=computingHiddenDelta(delta,layerInput,numOfWeightLayer,derivActFunctions,sparse,ffwNet,learnParams)
if sparse==1
  derivSparsityFunc=learnParams.derivSparsityFunc;
  lambda=learnParams.lambda;
  if numOfWeightLayer == 1
%     delta{numOfWeightLayer} = delta{numOfWeightLayer} .* derivActFunctions{numOfWeightLayer}(layerInput{numOfWeightLayer});
    delta{numOfWeightLayer} = delta{numOfWeightLayer} + lambda .* derivSparsityFunc(layerInput{numOfWeightLayer});
  else
    delta{numOfWeightLayer-1}  = delta{numOfWeightLayer} * ffwNet.W{numOfWeightLayer}; 
    delta{numOfWeightLayer-1}  = delta{numOfWeightLayer-1} .* derivActFunctions{numOfWeightLayer-1}(layerInput{numOfWeightLayer-1});
    delta{numOfWeightLayer-1}  = delta{numOfWeightLayer-1} + lambda .* derivSparsityFunc(layerInput{numOfWeightLayer-1});
  end
elseif sparse == 2
    derivSparsityFunc=learnParams.derivSparsityFunc;
    lambda=learnParams.lambda;
    if numOfWeightLayer == 1
      delta{numOfWeightLayer} = delta{numOfWeightLayer} + lambda * derivSparsityFunc(layerInput{numOfWeightLayer}) .* derivActFunctions{numOfWeightLayer}(layerInput{numOfWeightLayer});
    else
      delta{numOfWeightLayer-1}  = delta{numOfWeightLayer} * ffwNet.W{numOfWeightLayer}; 
      delta{numOfWeightLayer-1}  = delta{numOfWeightLayer-1} .* derivActFunctions{numOfWeightLayer-1}(layerInput{numOfWeightLayer-1});
      delta{numOfWeightLayer-1}  = delta{numOfWeightLayer-1} + lambda * derivSparsityFunc(layerInput{numOfWeightLayer-1}) .* derivActFunctions{numOfWeightLayer-1}(layerInput{numOfWeightLayer-1});
    end
else
    for i=numOfWeightLayer-1:-1:1
        delta{i}=delta{i+1} * ffwNet.W{i+1};
        delta{i}=derivActFunctions{i}(layerInput{i}) .* delta{i}; 
    end
end
return;

function [derW,derB]=computingWeightAndBiasGradient(derW, derB, layerOutput, ffwNet,delta,useBias)
numOfweightLayers=ffwNet.numOfweightLayers;
for i=2:numOfweightLayers
    derW{i} = delta{i}' * layerOutput{i-1};
end
if useBias==1
    for i=1:numOfweightLayers
        derB{i} = sum(delta{i})';
    end
else
    for i=1:numOfweightLayers
        derB{i} = zeros(size(ffwNet.B{i}));
    end
end

return;
function [compWeightGradient,compInputGradient,pointIndexes]= initP(params)
compWeightGradient=1; 
compInputGradient=0; 
pointIndexes=[];
len=length(params);
if len>0
    for i=1:2:len-1
        switch lower(params{i})
            case {'compweightgradient'}
                compWeightGradient=params{i+1};
            case {'compinputgradient'}
                compInputGradient=params{i+1};
            case {'pointindexes'}
                pointIndexes=params{i+1};
            otherwise
                disp('Error in input parameters for computeGradient');
                return;
        end
    end
end
    
    

return
