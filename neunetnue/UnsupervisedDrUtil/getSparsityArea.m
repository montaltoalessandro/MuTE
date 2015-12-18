function [area sp] = getSparsityArea(coeff, xRange)

% xRange = abs(coeff(:));

lenX   = length(xRange);
sp     = zeros(1,lenX);

for k = 1 : lenX
	sp(k) = computeSparsity(coeff,xRange(k));
end

area = sum(sp) / lenX;


return;
