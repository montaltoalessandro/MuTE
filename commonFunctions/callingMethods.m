function [output] = callingMethods(data,dataNN,params)
% 
% Syntax:
% 
% callingMethods(data,methodCell,params);
% 
% Description:
% 
% the function calls each method and saves the results in the method folder

% extracting the global parameters
% globalParameters        = params.globalParameters;

methodNames      = fieldnames(params.methods);
numMethods       = length(methodNames);
output           = cell(1,numMethods);

for i = 1 : numMethods
    methodName      = methodNames(i,1);
    currentMethod   = str2func(methodName{1,1});
    disp(['Method         :    ' methodName{1,1}]);
    if (sum(strcmp(methodName,'neunetnue')))
        output{1,i}     = currentMethod(dataNN,params.methods.(methodName{1,1}));
    else
        output{1,i}     = currentMethod(data,params.methods.(methodName{1,1}));
    end
end



return;