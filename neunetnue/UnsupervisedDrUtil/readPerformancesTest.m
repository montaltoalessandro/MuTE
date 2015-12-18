function result=readPerformancesTest(expFolder,methodName,dictSize)

testOutputDir = [expFolder 'Test_with_dict_' num2str(dictSize)];
dirPath       = [testOutputDir '/Methods/' lower(methodName)];
dirFile       = dir(dirPath);
matFile       = dir([dirPath '/' dirFile(3).name]);
matData       = load([dirPath '/' dirFile(3).name '/' matFile(3).name]);

result.performance = matData.saveStruct.params.perfomance;
result.dictNum     = matData.saveStruct.params.dictIndex;
out     = getLearningCoeffAndDict(expFolder,methodName, dictSize, result.dictNum);


result.dict  = out.dict;
result.coeff =  matData.saveStruct.coeff;

return