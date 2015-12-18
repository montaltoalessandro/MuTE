function [sens,spec] = sensitivity_specificity (seriesLengthVect,idTP,realizations)
    
    mainFolder = pwd;
    sens = zeros(length(seriesLengthVect),7);
    spec = zeros(length(seriesLengthVect),7);
    for i = 1:length(seriesLengthVect)
        folder = dir(['*' num2str(seriesLengthVect(i)) '_*_nonLinear']);
        cd([folder.name '/' 'entropyMatrices/']);
        methods{1,1}='binTransferEntropy';
        methods{1,2}='linearTransferEntropy';
        methods{1,3}='uniTENearNeighbour';
        methods{1,4}='nonUniformTransferEntropy';
        methods{1,5}='linearNonUniformTransferEntropy';
        methods{1,6}='nonUniTENearNeighbour';
        methods{1,7}='nonUniNeuralNet';

        signif = zeros(7,20);
        load('binTransferEntropy_transferEntropyMtx.mat');
        load('binTransferEntropy_testThresholdMtx.mat');
        signif(1,1:20) = sum(matrixTransferEntropy(:,2:end)>testThresholdMtx(:,2:end));
        load('linearTransferEntropy_transferEntropyMtx.mat')
        load('linearTransferEntropy_matrixPValues.mat')
        signif(2,1:20) = sum(matrixTransferEntropy(:,2:end)>matrixPValues(:,2:end));
        load('uniTENearNeighbour_transferEntropyMtx.mat');
        load('uniTENearNeighbour_testThresholdMtx.mat');
        signif(3,1:20) = sum(matrixTransferEntropy(:,2:end)>matrixPValues(:,2:end));
        load('nonUniformTransferEntropy_significanceOnDriv.mat')
        signif(4,1:20) = sum(significanceOnDrivers);
        load('linearNonUniformTransferEntropy_significanceOnDriv.mat')
        signif(5,1:20) = sum(significanceOnDrivers);
        load('nonUniTENearNeighbour_significanceOnDriv.mat')
        signif(6,1:20) = sum(significanceOnDrivers);
        load('nonUniNeuralNet_significanceOnDriv.mat')
        signif(7,1:20) = sum(significanceOnDrivers);
        
        FP           = signif;
        FP(:,idTP)   = [];
        TN           = sum(realizations - FP');
        FP           = sum(FP');
        TP           = sum(signif(:,idTP)');
        FN           = sum(realizations - signif(:,idTP)');

        sens(i,:) = TP ./ (TP + FN);
        spec(i,:) = TN ./ (TN + FP);
        cd(mainFolder);
    end
    
    

return;