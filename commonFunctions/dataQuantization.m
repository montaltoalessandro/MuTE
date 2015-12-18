function [dataPreprocessed]     = dataQuantization(data,methodParams,idSeriesToProcess)
%
% Syntax:
%
% [dataPreprocessed]     = dataQuantization(data,methodParams,idSeriesToProcess)
%
% Description:
%
% the function accepts data and quantizes the data according to
% idSeriesToProcess. If idSeriesToProcess is not present means you want to
% quantize all the series because you are working with multivariate
% analysis
% 
% Input:
% 
% data                  : matrix data
% 
% methodParams          : structure containing the current method 
%                         parameters
% 
% idSeriesToProcess     : vector containing only the necessary series to be
%                         quantized. If the field is not present the
%                         quantization will be performed for all the series
% 
% Output:
% 
% output                : matrix of quantized data
% 
% Calling function:
% 
% quantization
    
    
    numQuantLevels            = methodParams.numQuantLevels;


    if (nargin < 3)
        
        dataPreprocessed          = data;
        [numSeries numPoints]     = size(data);
        maxDataValue              = zeros(1,numSeries);
        minDataValue              = zeros(1,numSeries);
        amplitudeQuantLevels      = zeros(1,numSeries);
        levels                    = zeros(numQuantLevels,numSeries);
        
        for i = 1 : numSeries
            maxDataValue(1,i)              = max(data(i,:));
            minDataValue(1,i)              = min(data(i,:));
            amplitudeQuantLevels(1,i)      = (maxDataValue(1,i) - minDataValue(1,i)) / numQuantLevels;
        end
        
        for i = 1 : numQuantLevels
            levels(i,:) = minDataValue + (amplitudeQuantLevels .* i);
        end
        
        for i = 1 : numSeries%parfor
            for j = 1 : numPoints
                idLevels = 1;
                while (data(i,j) >= levels(idLevels,i) && idLevels < numQuantLevels)
                    idLevels = idLevels + 1;
                end
                dataPreprocessed(i,j) = idLevels;
            end
        end
    else
        numSeriesToProcess        = length(idSeriesToProcess);
    
        dataPreprocessed          = data;
        maxDataValue              = zeros(1,numSeriesToProcess);
        minDataValue              = zeros(1,numSeriesToProcess);
        amplitudeQuantLevels      = zeros(1,numSeriesToProcess);
        levels                    = zeros(numQuantLevels,numSeriesToProcess);

        for i = 1 : numSeriesToProcess
            maxDataValue(1,i)              = max(data(idSeriesToProcess(i,1),:));
            minDataValue(1,i)              = min(data(idSeriesToProcess(i,1),:));
            amplitudeQuantLevels(1,i)      = (maxDataValue(1,i) - minDataValue(1,i)) / numQuantLevels;
        end

    %     setting the levels
        for i = 1 : numQuantLevels
            levels(i,:) = minDataValue + (amplitudeQuantLevels .* i);
        end
        numSeries        = size(idSeriesToProcess,1);
        numPoints        = size(data,2);
        for i = 1 : numSeries
            seriesToProcess = idSeriesToProcess(i,1);
            for j = 1 : numPoints%parfor
                idLevels = 1;
                while (data(seriesToProcess,j) >= levels(idLevels,i) && idLevels < numQuantLevels)
                    idLevels = idLevels + 1;
                end
                dataPreprocessed(seriesToProcess,j) = idLevels;
            end
        end
    end


return;