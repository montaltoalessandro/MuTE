function output=ffwSim(ffwNet, X)
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
output = X;

if (useBias==1)
    
    bias = ones(N,1);

    for i=1:numOfweightLayers

        W = ffwNet.W{i};         % Getting weights
        B = ffwNet.B{i};         % Getting bias
        actFunc = ffwNet.actFunctions{i};   % Getting activation function
        % Computing Output
        output = actFunc([output bias] * [W B]');

    end
else
    for i=1:numOfweightLayers
        W = ffwNet.W{i};         % Getting weights
        actFunc = ffwNet.actFunctions{i};   % Getting activation function
        % Computing output
        output = actFunc(output * W');
    end
end

return;