function [SQE min_ max_ mean_ std_]=SQError(output,target,fast)
% [SQE min_ max_ mean_ std_]=SQError(output,target,fast)

diff=(output-target).^2;

sum1=sum(diff');

if (nargin < 3)
        min_=min((1/2)*diff);
        max_=max((1/2)*diff);
        mean_=mean((1/2)*diff);
        std_=std((1/2)*diff);
end

SQE=(1/2)*(sum(sum1));


return;