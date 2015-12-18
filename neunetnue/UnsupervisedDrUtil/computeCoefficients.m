function computeCoefficients(X, featuresIndex, numComps, dictionariesDir, outDir, numProcessors, testParams)
% computeCoefficients(X, featuresIndex, numComps, dictionariesDir, outDir, numProcessors, [testParams])

if (numProcessors > 1)
    try
        disp('Destroing any existance matlab pool session');
        matlabpool close;        
    catch
        disp('No matlab pool session found');
    end
    matlabpool(numProcessors)
end


% TESTING
if (nargin == 6)
    % Using learning parameters to compute coefficients
    fprintf('\nUSING LEARNING PARAMETERS TO COMPUTE COEFFICIENTS\n');     
    methodNames = manageMethods('getMethodsList', dictionariesDir); 
    for i=1:length(methodNames)
        methodName    = methodNames{i};	
        numParams     = manageParamStruct('getNumParams',dictionariesDir, methodNames{i});
        fprintf('\nLEARNING -> Method Name: %10s | Dict Size: %4d | Num params: %d\n',methodName,numComps,numParams); 
        
        Coeff = cell(1,numParams);    
        Dict  = cell(1,numParams);        
        parfor j=1:numParams
            if (manageDict('existDict',dictionariesDir, methodName, int2Vect(j,numParams), numComps))
                if (~manageCoeff('exist',outDir,methodName,int2Vect(j,numParams), numComps))                
                    [Dict{j} coeff learnData] = manageDict('get',dictionariesDir, methodName, int2Vect(j,numParams), numComps);
                    Coeff{j}                  = unsupWrapper(X, numComps, methodName2functionName(methodName), learnData, Dict{j}(featuresIndex,:), learnData);
                    manageCoeff('put',outDir,methodName,int2Vect(j,numParams), numComps, Coeff{j}, learnData);
                    Coeff{j} = 0;
                    Dict{j}  = 0;
                end
            end            
        end
        
    end
else
    % Using new parameters to compute coefficients
    fprintf('\nUSING NEW PARAMETERS TO COMPUTE COEFFICIENTS\n'); 
    featuresIndex = 1:size(X,2);
    
    methodNames = fieldnames(testParams);

    for i=1:length(methodNames)
        methodName      = methodNames{i};	
        runParams       = getRunParams(testParams, methodName);
        len_runParams   = length(runParams);
                
        totalDictionaries    = manageParamStruct('getNumParams',dictionariesDir, methodNames{i});
        
        for k=1:totalDictionaries
            
            fprintf('\nLEARNING -> Method Name: %10s | Dict Size: %4d | Num params: %d\n',methodName,numComps,len_runParams); 

            Coeff = cell(1,length(runParams));    
            Dict  = cell(1,length(runParams));       
            if (manageDict('existDict',dictionariesDir, methodName, int2Vect(k,totalDictionaries), numComps))
                parfor j=1:len_runParams

                        if (~manageCoeff('exist',outDir,methodName,int2Vect(k,totalDictionaries),int2Vect(j,len_runParams), numComps))                
                            [Dict{j} coeff learnData] = manageDict('get',dictionariesDir, methodName, int2Vect(k,totalDictionaries), numComps);
                            Coeff{j} = unsupWrapper(X, numComps, functionName, runParams{j}, Dict{j}(featuresIndex,:), learnData);
                            manageCoeff('put',outDir,methodName,int2Vect(k,totalDictionaries),int2Vect(j,len_runParams), numComps, Coeff{j}, runParams{j});
                            Coeff{j} = 0;
                            Dict{j}  = 0;
                        end

                end
            end    
        end
        
    end    
    
end

if (numProcessors > 1)
    matlabpool close;
end

return;