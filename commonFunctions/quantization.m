function [dataPreprocessed] = quantization(data,seriesToPreprocess,multi_bivAnalysis,methodParams)
% 
% Syntax:
% 
% [dataPreprocessed] = quantization(data,seriesToPreprocess,multi_bivAnalysis,methodParams)
% 
% Description:
% 
% the function preprocesses the data according the quantization theory,
% replacing every data entry with the quantization level it belongs to.
% 
% Input:
% 
% data                  : matrix data
% 
% seriesToPreprocess    : matrix containing the targets id chosen and, for
%                         each of them, the corresponding drivers id
% 
% multi_bivAnalysis     : field that allows to perform the analysis in
%                         bivariate or multivariate mode
% 
% methodParams          : structure containing the current method 
%                         parameters
% 
% Output:
% 
% dataPreprocessed      : matrix containing only the nacessary data rows
%                         preprocessed
% 
% Calling function:
% 
% the quantization step is called during the preprocess phase so, usually,
% the calling function is the method function
% 
% Example:
% 
% binTransferEntropy ; nonUniformTransferEntropy




    switch multi_bivAnalysis
        
        case 'biv'
%             in this case, looking at the seriesToProcess matrix, only a
%             restricted number of id with respect all the id available
%             could be chosen. To save time getSeriesToProcess returns only
%             the id series to be preprocessed
            idSeriesToProcess    = getSeriesToProcess(seriesToPreprocess);        
            dataPreprocessed     = dataQuantization(data,methodParams,idSeriesToProcess);
        case 'multiv'
%             in this case you have always to quantize all the series
            dataPreprocessed     = dataQuantization(data,methodParams);
    end
%%     
    
    
return;