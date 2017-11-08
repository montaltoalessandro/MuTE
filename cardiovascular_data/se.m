function se = se(data)
% calculates standard error of the mean
se = std(data)/sqrt(length(data));
