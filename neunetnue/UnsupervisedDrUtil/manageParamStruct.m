function result = manageParamStruct(operation, rootDir, method)
% result = manageParamStruct(operation, rootDir, method)

paramsFile = [rootDir '/Params/params.mat'];

if (~exist(paramsFile,'file'))
    disp('Error: not valid source dir');            
    return;
end

matData = load(paramsFile);
params  = matData.params;

switch (lower(operation))        
    case 'exist'
        result = existMethod(params, method);        
    case 'getmethodslist'
        result = getMethodsList(params);    
    case 'getnumparams'
        result = getNumParams(params, method, numComp);
    case 'getfunctionlist'
        result = getFunctionList(params);
    otherwise
        disp ('ERROR: unknown operation')
end    

return;

function result = getNumParams(params, method)
    runParams       = getRunParams(params, method);
    result          = length(runParams);
return;

function existFlag=existMethod(params, method)

    existFlag = 1;
    if (~isfield(params,method))        
        existFlag = 0;
    end
return;

function methods=getMethodsList(params)
    methods = fieldnames(params);    
return;

function methods=getFunctionList(params)
    
    methodsNames = fieldnames(params); 
    
    for i=1:length(methodsNames)        
        methods{i} = methodName2functionName(methodsNames{i});
    end
    
return;