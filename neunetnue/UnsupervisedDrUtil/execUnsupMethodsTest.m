function execUnsupMethodsTest(X,params,expFolder)
%function execUnsupMethodsTest(X,params,expFolder)
dictSize=params.globalParameters.dictSize;
% Chiamo readPerfomances
methodNames=getMethodNames(params);

if not(expFolder(end)=='/')
    expFolder=[expFolder '/'];
end
outDir  =[expFolder 'Test_with_dict_' num2str(dictSize)];
inDir   =[expFolder 'Learning_with_dict_' num2str(dictSize)];
for i=1:length(methodNames)
    result=readPerformances(expFolder,methodNames{i},dictSize);
    bestValResult = params.globalParameters.getBestValidationParams(result);
    params.(methodNames{i}).dictIndex  = bestValResult.numDict;
    params.(methodNames{i}).coeffIndex = bestValResult.numCoeff;
end

execUnsupMethodsValidation(X,params,inDir,outDir,1);

return;