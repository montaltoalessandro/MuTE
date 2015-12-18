function [dict coeff runParams encDict] = manageDict(operation, sourceDestDir, method, paramId, dictSize, runParams,  dict, coeff, encDict)
% [dict coeff dictParams] = manageDict(operation, sourceDestDir, method, paramId, numComp, dict, coeff)

method = lower(method);

%params.dictDirName   = 'Learning';
%params.rootDir       = [sourceDestDir '/Methods/'  lower(method) '/' params.dictDirName '/'];                         
params.rootDir       = [sourceDestDir '/Methods/'  lower(method) '/']; 
switch (lower(operation))
    case 'put'
        %runParams=runParamsOrNumComp;
        %numComp=runParams.dictSize;
        params.dictFileName  = [method '_' int2str(dictSize) '_dict'];        
        params.dictFile      = [params.rootDir params.dictFileName];
        putDict(dict, coeff, encDict, paramId, params,runParams);
  
    case 'get'
        %numComp=runParamsOrNumComp;
        params.dictFileName  = [method '_' int2str(dictSize) '_dict'];        
        params.dictFile      = [params.rootDir params.dictFileName];
        [dict coeff runParams encDict]=getDict(paramId, params);        
    case 'exist' %O gia' c'e' o qualcuno lo sta calcolando
        %numComp=runParamsOrNumComp;
        params.dictFileName  = [method '_' int2str(dictSize) '_dict'];        
        params.dictFile      = [params.rootDir params.dictFileName];
        dict = existDict(paramId, params);   
    case 'existdict' % E' già stato calcolato
        %numComp=runParamsOrNumComp;
        params.dictFileName  = [method '_' int2str(dictSize) '_dict'];        
        params.dictFile      = [params.rootDir params.dictFileName];

        dict = existDictionary(paramId, params);   
    otherwise
        disp 'ERROR: unknown operation'
end

return;

function existFlag=existDictionary(paramId, params)      
    
    dict_fileName  = getFileName(params.dictFile,paramId);
    
    existFlag = 0;
    if (exist(dict_fileName,'file'))
        existFlag = 1;
    end
        
return;


function existFlag=existDict(paramId, params)      
    
    dict_fileName  = getFileName(params.dictFile,paramId);
    %coeff_fileName = getFileName(params.coeffFile,paramId);  
    
    existFlag=existTest(dict_fileName);
        
 return;
 

function [dict coeff learnData encDict]=getDict(paramId, params)
    
    dict_fileName  = getFileName(params.dictFile,paramId);
    %coeff_fileName = getFileName(params.coeffFile,paramId);    
 
    matData    = load(dict_fileName);
    dict       = matData.saveStruct.dict;
    encDict    = matData.saveStruct.encDict;
    coeff      = matData.saveStruct.coeff;  
    if (isfield(matData.saveStruct,'learnData'))
        learnData  = matData.saveStruct.learnData;
    else
        learnData = [];
    end
 
 return;
  
 function putDict(dict, coeff, encDict,paramId, params, runParams)
    
    [status,message,messageid] = mkdir(params.rootDir);
    
    dict_fileName  = getFileName(params.dictFile,paramId);
    %coeff_fileName = getFileName(params.coeffFile,paramId);  
    
    saveStruct.coeff  = coeff;
    saveStruct.dict   = dict;
    saveStruct.encDict=encDict;
    [mean_s std_s]  = getSparsity(coeff);
    
    runParams.stat.coeffSparse.mean = mean_s;
    runParams.stat.coeffSparse.std  = std_s;
    
    saveStruct.learnData = runParams;
    
    saveStruct.PCname = getPcName();
        
    save(dict_fileName, 'saveStruct');
    
    deleteFlagFileName(dict_fileName);

return;


