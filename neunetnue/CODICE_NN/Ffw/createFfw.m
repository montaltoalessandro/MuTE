function net=createFfw(numNodesForLayers,actFunctions, initType, useBias)
%function net=createFfw(numNodesForLayers,activationFunctions, initType, useBias)
%
%Multi-layered Feed-Forward Network constructor
%
% INPUT  :  numNodesForLayers is a one-dimensional array
%           (optional) activationFunctions is a cell-array which contains 
%           function pointers. The default is {@sigmoid @sigmoid ...
%           @identity}.
%           (optional) useBias >0 indicates that the bias is used. The
%           default is useBias=1.
%           initType: 1 use uniform random weights between -1 and 1
%                     2 use gaussian random weights with 0 mean and 1 std
%           
% OUTPUT : net is a structure composed of the following fields:
%           - A cell array W which contains the weiths of each weight
%           layer. For example W{1} is a mxd random matrix where d is equal
%           numNodesForLayers(1) and m is equal to numNodesForLayers(2).
%           Each W{i} is a random matrix in [-1,1].
%           - A cell array B which contains the biases of each node layer.
%           For example B{1} is mx1 vector. If useBias is equal to 0 B{i}
%           is a 0 vector, otherwise is random vector in [-1,1].
%           - A cell array activationFunctions containing the activation
%           functions given in input.
%           - The scalars useBias, numOfweightLayers and numNodesForLayers.
%
% Examples :    - net=createFfw([2 5 3],{@sigmoid @sigmoid},1,0);
%               - net=createFfw([2 5 3]);
%               - net=createFfw([2 5 3],{@sigmoid @identity},2,1);    
if nargin <4
    useBias=1;
end
if nargin <3
    useBias=1;
    initType=1;
end

numOfweightLayers=length(numNodesForLayers)-1;
if nargin<2
    for i=1:numOfweightLayers-1;
        actFunctions{i}=@sigmoid;
    end
    actFunctions{numOfweightLayers}=@identity;
end

net=struct();

for i=1:numOfweightLayers
    if initType == 1
        net.W{i}=1-2*rand(numNodesForLayers(i+1),numNodesForLayers(i));
    end
    if initType == 2
       net.W{i}=randn(numNodesForLayers(i+1),numNodesForLayers(i));
    end
    net.actFunctions{i}=actFunctions{i};
end
net.useBias=useBias;
if useBias>0
    for i=1:numOfweightLayers        
        if initType == 1
            net.B{i}=1-2*rand(numNodesForLayers(i+1),1);
        end
        if initType == 2
            net.B{i}=randn(numNodesForLayers(i+1),1);
        end
    end
else
    for i=1:numOfweightLayers
        net.B{i}=zeros(numNodesForLayers(i+1),1);
    end
end
net.numOfweightLayers=numOfweightLayers;
net.numNodesForLayers=numNodesForLayers;
