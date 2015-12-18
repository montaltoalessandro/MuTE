function [bestResult] = getBestValidationParams(result)
% [bestResult] = getBestValidationParams(result)


[min_val min_index]=min(result.performance);

bestResult.numDict     = result.numDict(min_index);
bestResult.numCoeff    = result.numCoeff(min_index);
bestResult.performance = min_val;

if isfield(result,'valRunFields') 
    fields = result.valRunFields;

    for i=1:length(fields)
        bestResult.(fields{i}) = result.(fields{i})(min_index);
    end

    bestResult.valRunFields = fields;
end

return;
