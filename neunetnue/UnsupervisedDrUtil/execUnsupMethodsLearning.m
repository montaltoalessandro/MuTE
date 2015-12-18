function execUnsupMethodsLearning(X,params,outDir,numProcessors)
%function execUnsupMethondsLearning(X,params,dictSize,outDir,numProcessors)

if nargin<4
 numProcessors=1;
end
%%CODE FOR PARALLEL RUN
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
%%*************************
globalParameters=params.globalParameters;
dictSize=globalParameters.dictSize;
%methodNames = fieldnames(params);
%methodNames=methodNames(not(strcmp('globalParameters',methodNames))>0);
methodNames=getMethodNames(params);
for i=1:length(methodNames)
    %i
    methodName    = methodNames{i}; 
    runParams     = getRunParams(params, methodName);	
    len_runParams = length(runParams);
    fprintf('\nLEARNING -> Method Name: %10s | Dict Size: %4d | Num params: %d\n',methodName,dictSize,len_runParams); 
    
    identifierVect        = cell(1,length(runParams));
    for j=1:len_runParams
        identifierVect{j}=int2Vect(j,len_runParams);
    end
    funcDelimInd = strfind(methodName,'_');
    if ~isempty(funcDelimInd)
        functionName = methodName(1:funcDelimInd(1)-1);
    else
        functionName = methodName;
    end

    if numProcessors>1
        parfor j=1:len_runParams%parfor
            computeMethodLearning(X,outDir,methodName,globalParameters,identifierVect{j},runParams{j});
        end
    else
        [Dict Coeff EncDict]=computeMethodLearning(X,outDir,methodName,globalParameters,identifierVect{1},runParams{1});        
        for j=2:len_runParams
            currParams = runParams{j};
            currParams.Dict = Dict;
            currParams.Coeff = Coeff;
            currParams.EncDict = EncDict;
            [Dict Coeff EncDict]=computeMethodLearning(X,outDir,methodName,globalParameters,identifierVect{j},currParams);                    
        end
%         for j=1:len_runParams
%             computeMethodLearning(X,outDir,methodName,globalParameters,identifierVect{j},runParams{j});
%         end
    end
    
end
if numProcessors>1
     matlabpool close;
end

return;

function [Dict Coeff EncDict]=computeMethodLearning(X,outDir,methodName,globalParameters,identifierVect,runParams)
      dictSize=globalParameters.dictSize;
      if ~manageDict('exist', outDir, methodName, identifierVect, dictSize)
            [out runParams]=wrapperUnsupMethods(X, runParams,globalParameters);
            Dict=out.decodingDict;
            Coeff=out.encodedData;
            EncDict=out.encodingDict;
            fprintf('\nLEARNING -> Method Name: %10s | Dict Size: %4d : Saving Dict and Coeff...\n',methodName,dictSize);
            manageDict('put', outDir, methodName, identifierVect, dictSize,runParams,Dict, Coeff,EncDict);
      end
 return

% function computeMethodLearning(X,outDir,methodName,globalParameters,identifierVect,runParams)
%       dictSize=globalParameters.dictSize;
%       if ~manageDict('exist', outDir, methodName, identifierVect, dictSize)
%             [out runParams]=wrapperUnsupMethods(X, runParams,globalParameters);
%             Dict=out.decodingDict;
%             Coeff=out.encodedData;
%             EncDict=out.encodingDict;
%             fprintf('\nLEARNING -> Method Name: %10s | Dict Size: %4d : Saving Dict and Coeff...\n',methodName,dictSize);
%             manageDict('put', outDir, methodName, identifierVect, dictSize,runParams,Dict, Coeff,EncDict);
%       end
%  return