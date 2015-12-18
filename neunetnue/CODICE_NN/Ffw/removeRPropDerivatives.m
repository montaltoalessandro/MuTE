function [learnParams] = removeRPropDerivatives(learnParams)

if (isfield(learnParams,'deltaRBP'))
    learnParams=rmfield(learnParams,'deltaRBP');
end

if (isfield(learnParams,'prevGrad'))
    learnParams=rmfield(learnParams,'prevGrad');
end
