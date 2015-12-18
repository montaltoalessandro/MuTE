function [data] = buildNNdata (dataFolder)

    cd (dataFolder)

    exps              = dir('exp*');
    numExps           = length(exps);
    dataPerExp        = 500;
    data             = zeros(59,dataPerExp*numExps);

    j = 1;
    for i = 1:numExps
        load(exps(i).name);
        if (j*dataPerExp > length(data.eeg))
            j = 1;
        end
        data(:,(i-1)*dataPerExp+1:dataPerExp*i) = data.eeg(:,(j-1)*dataPerExp+1:dataPerExp*j);
        j = j+1;
    end
    save('nnExp','data');
    
return;