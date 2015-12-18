function execUnsupMethods(X, numComps, outDir, params, numProcessors, inDir, featuresIndex)
% execUnsupMethods(X, numComps, outDir, params, numProcessors, inDir, featuresIndex)
%CODE FOR PARALLEL RUN
%**********************
if (numProcessors > 1)
    try
        disp('Destroing any existance matlab pool session');
        matlabpool close;        
    catch
        disp('No matlab pool session found');
    end
    matlabpool(numProcessors)
end
%*************************
methodNames = fieldnames(params);
%LEARNING PHASE IF THE PARAMETER inDir IS ABSENT
%inDir IS THE DIRECTORY IN WHICH THE LEARNED DICTIONARY IS LOCATED

if (nargin == 5)
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

        Coeff       = cell(1,length(runParams));
        Dict        = cell(1,length(runParams)); 
        learnData   = cell(1,length(runParams));
        EncDict     = cell(1,length(runParams));
        out         = cell(1,length(runParams));
       %methodParams=cell(1,length(runParams));
        parfor j=1:len_runParams	    
    %    for j=1:len_runParams	    
            %methodParams{j}.encodingDecodingFun=params.(methodName).encodingDecodingFun;
            %methodParams{j}.encodingFun=params.(methodName).encodingFun;
            %methodParams{j}.runParams=runParams{j};
            %methodParams{j}.dictSize=numComps;
            %if ~manageDict('exist', outDir, methodName, int2Vect(j,len_runParams), numComps, Dict{j}, Coeff{j})
            if ~manageDict('exist', outDir, methodName, int2Vect(j,len_runParams), numComps)
%                [Coeff{j} Dict{j} learnData{j}] = unsupWrapper(X, numComps, functionName, runParams{j});
%                methodParams{j}.allParameters=params.(methodName);
%                methodParams{j}.runParams=runParams{j};
                runParams{j}.dictSize=numComps;
                [out{j} runParams{j}]=wrapperUnsupMethods(X, runParams{j});
                Dict{j}=out{j}.decodingDict;
                Coeff{j}=out{j}.encodedData;
                EncDict{j}=out{j}.encodingDict;
                manageDict('put', outDir, methodName, int2Vect(j,len_runParams), runParams{j}, Dict{j}, Coeff{j},EncDict{j});
                Coeff{j} = 0;
                Dict{j}  = 0;
                %learnData{j} = 0;
                EncDict{j}=0;
            end
        end
    end
else
    % TESTING
    if (nargin == 7)
        X             = X(:,featuresIndex);            
    else
        featuresIndex = 1:size(X,2);
    end
    
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
        
        Coeff = cell(1,length(runParams));    
        Dict  = cell(1,length(runParams));        
        parfor j=1:len_runParams
            if (manageDict('existDict',inDir, methodName, int2Vect(j,len_runParams), numComps))
                if (~manageCoeff('exist',outDir,methodName,int2Vect(j,len_runParams), numComps))                
                    [Dict{j} coeff learnData] = manageDict('get',inDir, methodName, int2Vect(j,len_runParams), numComps);
                    Coeff{j} = unsupWrapper(X, numComps, functionName, runParams{j}, Dict{j}(featuresIndex,:), learnData);
                    manageCoeff('put',outDir,methodName,int2Vect(j,len_runParams), numComps, Coeff{j}, runParams{j});
                    Coeff{j} = 0;
                    Dict{j}  = 0;
                end
            end            
        end
    end    
end

if (numProcessors > 1)
    matlabpool close;
end

return;


function runParams=getRunParams(params, methodName)
    runFields       = params.(methodName).runFields;
    sParams         = cell(1,length(runFields));
    runFieldsValues = cell(1,length(runFields));
    runFieldsSize   = zeros(1,length(runFields));
    for j=1:length(runFields)
        sParams{j}         = params.(methodName).(runFields{j});
        runFieldsValues{j} = sParams{j};
        runFieldsSize(j)   = length(sParams{j});
    end
    
    out           = cell(1,numel(sParams));
    if (numel(sParams) == 1)
        out{1} = sParams{1};
    else
        [out{:}]      = ndgrid(sParams{:});    
    end
    runParamsVals = zeros(length(out{1}(:)),length(out));
    
    for i=1:length(out)
        runParamsVals(:,i) = out{i}(:);
    end
    
    runParams = cell(1,size(runParamsVals,1));
    for i=1:length(runParams)
        runParams{i} = params.(methodName);
        runParams{i}.runFieldsValues = runFieldsValues;
        runParams{i}.runFieldsSize   = runFieldsSize;
        for j=1:length(runFields)
            runParams{i}.(runFields{j}) = runParamsVals(i,j);
        end
    end

return;
