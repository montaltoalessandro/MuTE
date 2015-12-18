function methodNames=getMethodNames(params)
%function methodNames=getMethodNames(params)
methodNames = fieldnames(params);
methodNames=methodNames(not(strcmp('globalParameters',methodNames))>0);

return;