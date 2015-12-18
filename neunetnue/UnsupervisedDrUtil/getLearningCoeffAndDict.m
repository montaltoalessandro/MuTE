function [out]=getLearningCoeffAndDict(outputDir,methodName, dictSize, num)
%function [out]=getLearningCoeffAndDict(learnOutputDir,methodName, dictSize, num)

if not(outputDir(end)=='/')
    outputDir=[outputDir '/'];
end
learnOutputDir=[outputDir 'Learning_with_dict_' num2str(dictSize)];
out=[];
dirPath=[learnOutputDir '/Methods/' lower(methodName)];
files=dir(dirPath);
pattern=['_' num2str(dictSize) '_dict'];
count=0;
for i=1:length(files)
    if not(isempty(strfind(files(i).name,pattern)))
        count=count+1;
    end
end
if num<= count
    identVect=int2Vect(num,count);
    [dict coeff runParams projDict]= manageDict('get',learnOutputDir,methodName,identVect,dictSize);
    out.dict=dict;
    out.coeff=coeff;
    out.runParams=runParams;
    out.projDict=projDict;    
end
%[dict coeff runParams projDict]= manageDict('get',learnOutputDir,'paddle',1,dictSize);
return