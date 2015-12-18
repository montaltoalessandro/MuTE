function result = manageMethods(operation, sourceDestDir, method, numComp)
% result = manageMethods(operation, sourceDestDir, method, numComp)

params.methodsRoot   = [sourceDestDir '/Methods/'];


if (nargin > 2)    
    method = lower(method);
    params.dirName  = 'Testing';
    params.rootDir       = [params.methodsRoot lower(method) '/' params.dirName '/']; 
    if (~exist(params.rootDir,'file'))
        params.dirName  = 'Learning';
        params.rootDir       = [params.methodsRoot lower(method) '/' params.dirName '/']; 
        if (~exist(params.rootDir,'file'))
            disp('Error: not valid source dir');            
            return;
        end
    end
end

switch (lower(operation))        
    case 'exist'
        result = existMethod(params, method);        
    case 'getmethodslist'
        result = getMethodsList(params);
    case 'getnumcompslist'
        result = getNumComps(params);
    case 'getnumparams'
        result = getNumParams(params, method, numComp);
    case 'getfunctionlist'
        result = getFunctionList(params);
    otherwise
        disp ('ERROR: unknown operation')
end    

return;

function result = getNumParams(params, method, numComp)
    files = dir([params.rootDir method '_' int2str(numComp) '*.mat']);    
    result = length(files);
return;

function existFlag=existMethod(params, method)

    existFlag = 1;
    if (~exist([params.methodsRoot method],'file'))        
        existFlag = 0;
    end
return;

function numComps=getNumComps(params)
    files = dir([params.rootDir '*.mat']);
    
    numComps = zeros(1,length(files));
    %initPos  = length(method) + 2;    
    for i=1:length(files)
         positions = strfind(files(i).name,'_');
         initPos = positions(1)+1;
         endPos  = positions(2)-1;
        
        %endPos = length(coeff_files(i).name) - 10;
        numComps(i) = str2num(files(i).name(initPos:endPos));
    end
    
    numComps = unique(numComps);
    
return;

function methods=getMethodsList(params)
    methodsDir = dir(params.methodsRoot);
    methods    = cell(1,length(methodsDir) - 2);
    
    for i=3:length(methodsDir)
        methods{i-2} = methodsDir(i).name;
    end
    
return;

function methods=getFunctionList(params)
    methodsDir = dir(params.methodsRoot);
    methods    = cell(1,length(methodsDir) - 2);
    
    for i=3:length(methodsDir)        
        methods{i-2} = methodName2functionName(methodsDir(i).name);
    end
    
return;