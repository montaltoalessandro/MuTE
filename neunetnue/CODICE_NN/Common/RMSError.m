function [RMS sumNormTarget]=RMSError(output, target, targetVar)
% RMS=RMSError(output, target, [targetVar])

N=size(output,1);

if (nargin < 3)
    target_m=mean(target);

    target_mat=repmat(target_m,N,1);

    sumNormTarget=sum(snormMat(target,target_mat));
else
    sumNormTarget=targetVar;
end

sumNormInput=sum(snormMat(target,output));

RMS=sumNormInput/sumNormTarget;

return;