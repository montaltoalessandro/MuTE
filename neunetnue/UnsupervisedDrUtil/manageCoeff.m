function [coeff_methods_numComp coeffParams] = manageCoeff(operation, sourceDestDir, method, dictId, paramId, numComp, coeff, coeffParams)
% coeff_methods_numComp = manageCoeff(operation, sourceDestDir, method, dictId, paramId, numComp, coeff, coeffParams)
%
% Allows one to save and load coefficient matrix
%
% operation     : string, 'get', 'put', 'getMethodsList', 'getNumCompsList'
% sourceDestDir : string, input/output dir
% method        : string, unsupervised method name
% dictId        : int
% paramId       : int
% numComp       : int, the number of atoms
% coeff         : the coefficient matrix
if sourceDestDir(end)=='/'
   sourceDestDir=sourceDestDir(1:(end-1));
end
params.methodsRoot   = [sourceDestDir '/Methods/'];

method = lower(method);
%params.coeffDirName  = [getFileName('Dict_',dictId)];
params.coeffDir       = [params.methodsRoot lower(method) '/dict_' vect2str(dictId)];      



params.coeffFileName = [method '_' int2str(numComp) '_dict_' vect2str(dictId) '_coeff_' vect2str(paramId)];
params.coeffFile     = [params.coeffDir '/' params.coeffFileName '.mat'];

switch (lower(operation))
    case 'get'
        [coeff_methods_numComp coeffParams] = getCoeff(params.coeffFile);
    case 'exist'
        %coeff_methods_numComp = existCoeff(params.coeffFile);
        coeff_methods_numComp = existTest(params.coeffFile);
    case 'put'
        putCoeff(coeff, params, coeffParams);    
    otherwise
        disp ('ERROR: unknown operation')
end    

return;


function [coeff coeffParams]=getCoeff(coeffFile)
    
    matData     = load(coeffFile);
    coeff       = matData.saveStruct.coeff;
    coeffParams = matData.saveStruct.params;
 
 return;
 
 function putCoeff(coeff, params, coeffParams)
    if not(isdir(params.coeffDir)) 
        [status,message,messageid] = mkdir(params.coeffDir);
    end
    %coeff_fileName = getFileName(params.coeffFile, paramId); 
    
    [mean_s std_s]  = getSparsity(coeff);
    
    coeffParams.stat.coeffSparse.mean = mean_s;
    coeffParams.stat.coeffSparse.std  = std_s;
        
    saveStruct.coeff  = coeff;        
    
    saveStruct.params = coeffParams;
    
    saveStruct.PCname = getPcName();
    
    save(params.coeffFile,'saveStruct');
    
    deleteFlagFileName(params.coeffFile);
    
return;

 function strId=vect2str(vectId)
     strId  = '';
    
    for i=1:length(vectId)
        strId  = [strId int2str(vectId(i))];        
    end
 return;
% function methods=getMethodsList(params)
%     methodsDir = dir(params.methodsRoot);
%     methods = cell(1,length(methodsDir) - 2);
%     
%     for i=3:length(methodsDir)
%         methods{i-2} = methodsDir(i).name;
%     end
%     
% return;
% 
% function numComps=getNumComps(params)
%     coeff_files = dir([params.rootDir '*.mat']);
%     
%     numComps = zeros(1,length(coeff_files));
%     %initPos  = length(method) + 2;    
%     for i=1:length(coeff_files)
%          positions = strfind(coeff_files(i).name,'_');
%          initPos = positions(1)+1;
%          endPos  = positions(2)-1;
%         
%         %endPos = length(coeff_files(i).name) - 10;
%         numComps(i) = str2num(coeff_files(i).name(initPos:endPos));
%     end
%     
%     numComps = unique(numComps);
%     
% return;
