function [res]=snormMat(X,Y)
% [res]=snormMat(X,Y)

C=size(X,2);

diff=X-Y;

if (C==1)
    res=diff.^2;
else
    res=sum((diff.*diff)')';
end

return;