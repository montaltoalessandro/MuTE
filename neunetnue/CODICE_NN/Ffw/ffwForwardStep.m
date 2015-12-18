function [layerOutput layerInput]=ffwForwardStep(ffwNet, X)
% function [layerOutput layerInput]=ffwForwardStepMat(ffwNet, X)
%
% Forward step for N-layered feedforward neural networks
%
% INPUT  : ffwNet -- Network Structure
%          X      -- Nxd input matrix
%
% OUTPUT :  layerOutput -- cell array of layer outputs
%           layerInput -- cell array of layer inputs
%
N=size(X,1);

useBias = ffwNet.useBias;
numOfweightLayers = ffwNet.numOfweightLayers;
layerInput=cell(1,numOfweightLayers);
layerOutput=cell(1,numOfweightLayers);
p_layerOutput = X;

if (useBias==1)
    
    bias = ones(N,1);

    for i=1:numOfweightLayers

        W = ffwNet.W{i};         % Getting weights

        B = ffwNet.B{i};         % Getting bias

        actFunc = ffwNet.actFunctions{i};   % Getting activation function

        % Computing Layer Input
        layerInput{i} = [p_layerOutput bias] * [W B]';

        % Computing Layer Output
        layerOutput{i} = actFunc(layerInput{i});
        p_layerOutput=layerOutput{i};
    end
else
    for i=1:numOfweightLayers

        W = ffwNet.W{i};         % Getting weights
        
        actFunc = ffwNet.actFunctions{i};   % Getting activation function

        % Computing Layer Input
        layerInput{i} =     p_layerOutput * W';

        % Computing Layer Output
        layerOutput{i} = actFunc(layerInput{i});
        p_layerOutput = layerOutput{i};    
    end
end

return;