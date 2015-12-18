function vect = int2Vect(num, maxNum)

maxLen  = length(int2str(maxNum));
numstr  = int2str(num);
lenDiff = maxLen - length(numstr);

vect    = zeros(1,maxLen);

for i=lenDiff+1:maxLen
    vect(i) = str2num(numstr(i-lenDiff));
end

return;