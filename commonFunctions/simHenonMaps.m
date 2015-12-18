function [data] = simHenonMaps (numSeries,nPoints,nTransient,coupling)
% function [data] = simHenonMaps (numSeries,nPoints,nTransient,coupling)



data         = zeros(nPoints+nTransient,numSeries);
data(1:2,:)  = rand(2,numSeries);

for j = 3 : nPoints+nTransient
    data(j,1) = 1.4 - (data(j-1,1))^2 + 0.3*data(j-2,1);
end

for i = 2:numSeries
    for j = 3 : nPoints+nTransient
        data(j,i) = 1.4 - (coupling*data(j-1,i-1) + (1-coupling)*data(j-1,i))*data(j-1,i) + 0.1*data(j-2,i);
    end
end

data     = data(nTransient+1:nPoints+nTransient,:);
data     = data';
return;