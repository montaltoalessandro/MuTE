function runParams=getRunParams(params, methodName,runFieldsName)
% runParams=getRunParams(params, methodName)
    if (nargin<3)
        runFieldsName='runFields';
    end
    runFields       = params.(methodName).(runFieldsName);
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
