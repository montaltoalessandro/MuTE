function execUnsupMethodsValidation(X,params,inDir,outDir,numProcessors)
if nargin<4
 numProcessors=1;
end

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
globalParameters=params.globalParameters;
dictSize=globalParameters.dictSize;
methodNames = fieldnames(params);
%List of method names
methodNames=methodNames(not(strcmp('globalParameters',methodNames))>0);


for i=1:length(methodNames)
    methodName    = methodNames{i};	         
    %dictRunParams: List of structures, each one representing the parameter
    %values used during learning
    %dict_len_runParams: lenght of the list.
    [dictRunParams dict_len_runParams dictIdentifierVect]=initDictParameters(params,methodName);
    
    %currValParams: List of structures, representing the parameters values
    %tob used during the validation phase. If the EncodigDictionary
    %(Projection Dictiorary) exists, this list corresponds to the list used
    %during the learning. The EncodingDictionary exists when the field 
    % valRunnFiles does not exists.  
    [valIdentifierVect,currValParams,currNumProcessors, useEncDict]=initValParameters(X,params,methodName,numProcessors,dictRunParams);

    val_len_runParams=length(currValParams{1});
    
    funcDelimInd = strfind(methodName,'_');
    if ~isempty(funcDelimInd)
        functionName = methodName(1:funcDelimInd(1)-1);
    else
        functionName = methodName;
    end
    
    if isfield(params.(methodName),'dictIndex')
        dictIndex  = params.(methodName).dictIndex;
        coeffIndex = params.(methodName).coeffIndex;
        singleValParams = cell(1);
        singleValParams{1} = currValParams{dictIndex}{coeffIndex};
        singleValIdentifierVect = cell(1);
        singleValIdentifierVect{1} = valIdentifierVect{coeffIndex};
        fprintf('\nTESTING -> Method Name: %10s | Dict Size: %4d | Best dict index: %d\n',methodName,dictSize,dictIndex);    
        if (manageDict('existDict',inDir, methodName, dictIdentifierVect{dictIndex}, dictSize))
                [Dict, Coeff , ~, encDict] = manageDict('get',inDir, methodName, dictIdentifierVect{dictIndex}, dictSize);
                computeMethodValidation(X,outDir,methodName,encDict,Dict, Coeff, globalParameters,dictIdentifierVect{dictIndex},singleValIdentifierVect,singleValParams,currNumProcessors,useEncDict);                
        end
    else
        fprintf('\nVALIDATION -> Method Name: %10s | Dict Size: %4d | Num params: %d\n',methodName,dictSize,val_len_runParams); 
        %     Coeff = cell(1,length(runParams));    
        Dict  = cell(1,length(dictRunParams));
        encDict = cell(1,length(dictRunParams));
        Coeff= cell(1,length(dictRunParams));    

        if numProcessors>1
            parfor j=1:dict_len_runParams%parfor

                if (manageDict('existDict',inDir, methodName, dictIdentifierVect{j}, dictSize))
                    [Dict{j}, Coeff{j} , ~, encDict{j}] = manageDict('get',inDir, methodName, dictIdentifierVect{j}, dictSize);
                    computeMethodValidation(X,outDir,methodName,encDict{j},Dict{j}, Coeff{j}, globalParameters,dictIdentifierVect{j},valIdentifierVect,currValParams{j},currNumProcessors,useEncDict);
                    Dict{j}=0;
                    encDict{j}=0; 
                    Coeff{j}=0;
                end
            end
        else
             for j=1:dict_len_runParams
                if (manageDict('existDict',inDir, methodName, dictIdentifierVect{j}, dictSize))
                     [Dict{j} , Coeff{j} , ~, encDict{j}] = manageDict('get',inDir, methodName, dictIdentifierVect{j}, dictSize);
                     computeMethodValidation(X,outDir,methodName,encDict{j}, Dict{j},Coeff{j},globalParameters,dictIdentifierVect{j},valIdentifierVect,currValParams{j},currNumProcessors,useEncDict);
                     Dict{j}=0;
                     encDict{j}=0;
                     Coeff{j}=0;
                end
            end
        end
    end
end

if numProcessors>1
     matlabpool close;
end

return;

function computeMethodValidation(X,outDir,methodName,encDic, Dict, Coeff, globalParameters,dictIdentifierVect,valIdentifierVect, valRunParams,numProcessors,useEncDict)

val_len_runParams=length(valIdentifierVect);
dictSize=globalParameters.dictSize;
if numProcessors>1 
    parfor h=1:val_len_runParams%parfor
        computeValAndSave(X, outDir, methodName, dictIdentifierVect,valIdentifierVect{h},dictSize,encDic,Dict,Coeff, globalParameters,valRunParams{h},useEncDict );
    end
else
     for h=1:val_len_runParams
        computeValAndSave(X, outDir, methodName, dictIdentifierVect,valIdentifierVect{h},dictSize,encDic,Dict,Coeff,globalParameters,valRunParams{h},useEncDict);
    end
end
return;

function computeValAndSave(X, outDir, methodName, dictIdentifierVect,valIdentifierVect,dictSize,encDict,Dict,CoeffLearning,globalParameters,valRunParams,useEncDict )
        if (~manageCoeff('exist',outDir,methodName,dictIdentifierVect,valIdentifierVect, dictSize))
            if useEncDict %In this case the encoding dictionary (projection dictionary) is used,
                          %and the field  'valRunFields' does not exist.
                          %The parameter 'valRunParams' corresponds 
                          %to one of the list of parameters used during the learning phase.
                          % currDict stores the encoding dictionary and
                          % it is to be used in the function handled by
                          % encodingFun. This function has funParams as one of the
                          % arguments, and FunParams has the field
                          % dict which stores the value of currDict. 
                currDict=encDict;
            else         %In this case the encoding dictionary (projection dictionary) does not exist,
                         %and the field  'valRunFields' exists.
                         %The parameter 'valRunParams' corresponds 
                         %to one of the the list of parameters stored in 'valRunFields'.   
                         % currDict stores the decoding dictionary and
                         % it is to be used in the function handled by
                         % encodingFun. This function has funParams as one of the
                         % arguments, and funParams has the field
                         % dict which stores the value of currDict.   
                currDict=Dict;
            end
            
            if not(isempty(X))
                [out valRunParams]=wrapperUnsupMethods(X,valRunParams,globalParameters, currDict);
                coeff=out.encodedData;
            else
                coeff=CoeffLearning;
            end
            %The variable coeff holds either or the coefficient computed
            %during the learning phase (When X is empty) or the new
            %coefficient computed during the validation phase.
            fprintf('\nVALIDATION -> Method Name: %10s | Dict Size: %4d : Saving Coeff...\n',methodName,dictSize);
            if isfield(globalParameters,'computePerformance')
                computePerformance=globalParameters.computePerformance;
                funParams.dict=Dict;
                %funParams.coeff=coeff;
                funParams.globalParameters=globalParameters;
                if not(isempty(X))
                    funParams.globalParameters.data=X;
                end
                perfomance=computePerformance(coeff,funParams);
                valRunParams.perfomance=perfomance;
            end
            manageCoeff('put',outDir,methodName,dictIdentifierVect, valIdentifierVect,dictSize, coeff, valRunParams);
        end
return

function [dictRunParams dict_len_runParams dictIdentifierVect]=initDictParameters(params,methodName)
    dictRunParams     = getRunParams(params, methodName);
    dict_len_runParams = length(dictRunParams);
    dictIdentifierVect        = cell(1,length(dictRunParams));
    for j=1:dict_len_runParams
        dictIdentifierVect{j}=int2Vect(j,dict_len_runParams);
    end
return


function [valIdentifierVect,currValParams,currNumProcessors, useEncDict]=initValParameters(X,params,methodName,numProcessors,dictRunParams)
    useEncDict=true;
    currNumProcessors=1;
    
    if isfield(params.(methodName),'valRunFields')
        useEncDict=false;
        currNumProcessors=numProcessors;
        valRunParams     = getRunParams(params, methodName,'valRunFields');
    end
    currValParams=cell(1,length(dictRunParams));
    for h=1:length(currValParams)
        if useEncDict || isempty(X)
            %If the Encoding Dictionary exists, the list of parameters 
            %is equal to the list of parameters used during the learning phase. 
            currValParams{h}={dictRunParams{h}};
        else
            %If the Encoding Dictionary does not exist, a new the set of parameters 
            %is associated to each decoding dictionary. Thi new set of
            %parameters is that stored in valRunFilelds;
            currValParams{h}=valRunParams;
        end
    end
    val_len_runParams = length(currValParams{1});
    valIdentifierVect        = cell(1,length(currValParams{1}));
    for h=1:val_len_runParams
       valIdentifierVect{h}=int2Vect(h,val_len_runParams);
    end
return;