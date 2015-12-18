function [mean_s std_s]=getSparsity(U)
%  [mean_s std_s]=getSparsity(U)
%
%  U : matrix n x K where n is the number of samples and K is the
%      dictionary size

K      = size(U,2);
binU   = abs(U) > 0;
sumRow = sum(binU,2) / K;
mean_s = mean(sumRow);
std_s  = std(sumRow);

return;