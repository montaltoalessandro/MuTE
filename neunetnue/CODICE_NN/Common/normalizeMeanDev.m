function [input]=normalizeMeanDev(input,mean,dev)

[R C]=size(input);

for i=1:R
    input(i,:)=(input(i,:)-mean)./dev;
end


return;
