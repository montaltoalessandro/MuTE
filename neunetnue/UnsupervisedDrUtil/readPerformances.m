function result=readPerformances(expFolder,methodName,dictSize)
numDict=1;
numCoeff=1;
out=getValidationCoeffAndParams(expFolder,methodName,dictSize,numDict,numCoeff);

if isfield(out.coeffParams,'valRunFields')           
    valRunFields=out.coeffParams.valRunFields;
    lenValRunFields=length(valRunFields);    
    result.valRunFields = valRunFields;    
    result.lenValRunFields = lenValRunFields;
else
    lenValRunFields = 0;
end

count=0;
while not(isempty(out))
    while not(isempty(out))
        count=count+1;
        result.numDict(count)=numDict;
        result.performance(count)=out.coeffParams.perfomance.score;
        result.numCoeff(count)=numCoeff;
        for i=1:lenValRunFields
            result.(valRunFields{i})(count)=out.coeffParams.(valRunFields{i});
        end        
        numCoeff=numCoeff+1;
        out=getValidationCoeffAndParams(expFolder,methodName,dictSize,numDict,numCoeff);
    end
    numCoeff=1;
    numDict=numDict+1;
    out=getValidationCoeffAndParams(expFolder,methodName,dictSize,numDict,numCoeff);
end

    
return
