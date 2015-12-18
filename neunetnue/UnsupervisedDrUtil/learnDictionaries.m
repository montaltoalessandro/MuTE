function learnDictionaries(X, numComps, outDir, params, numProcessors)
% learnDictionaries(X, numComps, outDir, params, numProcessors)

if (numProcessors > 1)
    try
        disp('Destroing any existance matlab pool session');
        matlabpool close;        
    catch
        disp('No matlab pool session found');
    end
    matlabpool(numProcessors)
end

methodNames = fieldnames(params);

% LEARNING
for i=1:length(methodNames)
    methodName    = methodNames{i}; 
    runParams     = getRunParams(params, methodName);	
    len_runParams = length(runParams);
    fprintf('\nLEARNING -> Method Name: %10s | Dict Size: %4d | Num params: %d\n',methodName,numComps,len_runParams); 

    funcDelimInd = strfind(methodName,'_');
    if ~isempty(funcDelimInd)
        functionName = methodName(1:funcDelimInd(1)-1);
    else
        functionName = methodName;
    end

    Coeff      = cell(1,length(runParams));
    Dict       = cell(1,length(runParams)); 
    learnData  = cell(1,length(runParams));
    parfor j=1:len_runParams	    
        if ~manageDict('exist', outDir, methodName, int2Vect(j,len_runParams), numComps, Dict{j}, Coeff{j})		
            [Coeff{j} Dict{j} learnData{j}] = unsupWrapper(X, numComps, functionName, runParams{j});
            manageDict('put', outDir, methodName, int2Vect(j,len_runParams), numComps, Dict{j}, Coeff{j}, learnData{j});
            Coeff{j}     = 0;
            Dict{j}      = 0;
            learnData{j} = 0;
        end
    end
end

    
if (numProcessors > 1)
    matlabpool close;
end

return;