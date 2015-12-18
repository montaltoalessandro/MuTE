% generate surrogate x with time shift
% used to study the significance of short term correlation on long term
% distance. The structure is preserved.

function xs=surrotimeshift(x,taumin,numsurr)

error(nargchk(1,3,nargin));
if nargin < 3, numsurr=1; end %default only 1 surrogate time series
if nargin < 2, taumin=1; end %default shift of one sample

N=length(x);
taumax=N-taumin;

tauvett=randperm(taumax-taumin+1)+taumin-1;% all possible shifts between taumin and taumax

if length(tauvett)<numsurr
    error('number of shift smaller than surrogates');
end

xs=zeros(N,numsurr);
for i=1:numsurr
    xs(:,i)=circshift(x,tauvett(i));
end



