function functionName=methodName2functionName(methodName)
% functionName=methodName2functionName(methodName)

funcDelimInd = strfind(methodName,'_');
if ~isempty(funcDelimInd)
    functionName = methodName(1:funcDelimInd(1)-1);
else
    functionName = methodName;
end

return;