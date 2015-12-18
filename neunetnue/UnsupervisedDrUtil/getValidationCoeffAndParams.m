function [out]=getValidationCoeffAndParams(outputDir,methodName, dictSize, numDict,numCoeff)

out=[];
if not(outputDir(end)=='/')
    outputDir=[outputDir '/'];
end

valOutputDir=[outputDir 'Validation_with_dict_' num2str(dictSize)];


out=[];
dirPath=[valOutputDir '/Methods/' lower(methodName)];
files=dir(dirPath);
pattern=['dict_'];
countDict=0;
indexDict=[];
for i=1:length(files)
    if not(isempty(strfind(files(i).name,pattern)))
        countDict=countDict+1;
        indexDict(countDict)=i;
    end
end

if numDict<= countDict
    
    identVectDict=int2Vect(numDict,countDict);
    files2=dir([dirPath '/' files(indexDict(numDict)).name]);
    pattern='.mat';
    countCoeff=0;
    for i=1:length(files2)
        if not(isempty(strfind(files2(i).name,pattern)))
            countCoeff=countCoeff+1;
        end
    end
    if numCoeff<=countCoeff
        identVectCoeff=int2Vect(numCoeff,countCoeff);
    
        [coeff coeffParams]= manageCoeff('get',valOutputDir,methodName,identVectDict,identVectCoeff,dictSize);
        out.coeff=coeff;
        out.coeffParams=coeffParams;
    end
end
return;