function [Y mean_ stdev]=normalizeInput(X, mean_, stdev)
% [Y mean_ stdev]=normalizeInput(X, mean_, stdev)

[R C]=size(X);

if (nargin == 1)
    % components are over column
    mean_=mean(X); % mean of sigle component
    stdev=std(X);  % standard deviation of single component
    index=find(stdev==0);
    if (~isempty(index))
        stdev(index)=ones(1,length(index));
    end
end


M=repmat(mean_,R,1);
SD=repmat(stdev,R,1);

% Centering
%Y=(X-M)./SD;
Y=(X-M);

return;
