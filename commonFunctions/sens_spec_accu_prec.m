function [sens,spec,accu,prec] = sens_spec_accu_prec (resultFolder,idTP,numTargets,numRealizations)
    
    cd(resultFolder);
    
    
%     methods{1,1}='binue';
%     methods{1,2}='binnue';
%     methods{1,3}='linue';
%     methods{1,4}='linnue';
%     methods{1,5}='nnue';
%     methods{1,6}='nnnue';
%     methods{1,7}='neunetnue';

    methods = dir('*transferEntropyMtx.mat');
    numMethods = length(methods);
    
    sens = zeros(1,numMethods);
    spec = zeros(1,numMethods);
    accu = zeros(1,numMethods);
    prec = zeros(1,numMethods);
    
    signif = zeros(numMethods,numTargets);
    
    for i = 1:numMethods
        if(strcmp('binue',methods(i).name(1:end-23)))
            load('binue_transferEntropyMtx.mat');
            load('binue_testThresholdMtx.mat');
            signif(i,:) = sum(matrixTransferEntropy(:,2:end)>testThresholdMtx(:,2:end),1);
        end
        
        if(strcmp('linue',methods(i).name(1:end-23)))
            load('linue_transferEntropyMtx.mat')
            load('linue_matrixPValues.mat')
            signif(i,:) = sum(matrixTransferEntropy(:,2:end)>matrixPValues(:,2:end),1);
        end
        
        if(strcmp('nnue',methods(i).name(1:end-23)))
            load('nnue_transferEntropyMtx.mat');
            load('nnue_testThresholdMtx.mat');
            signif(i,:) = sum(matrixTransferEntropy(:,2:end)>testThresholdMtx(:,2:end),1);
        end
        
        if(strcmp('binnue',methods(i).name(1:end-23)))
            load('binnue_significanceOnDriv.mat')
            signif(i,:) = sum(significanceOnDrivers,1);
        end
        
        if(strcmp('linnue',methods(i).name(1:end-23)))
            load('linnue_significanceOnDriv.mat')
            signif(i,:) = sum(significanceOnDrivers,1);
        end
        
        if(strcmp('nnnue',methods(i).name(1:end-23)))
            load('nnnue_significanceOnDriv.mat')
            signif(i,:) = sum(significanceOnDrivers,1);
        end
        
        if(strcmp('neunetnue',methods(i).name(1:end-23)))
            load('neunetnue_significanceOnDriv.mat')
            signif(i,:) = sum(significanceOnDrivers,1);
        end
    end

    TP = signif(:,idTP);
    TP = sum(TP,2);

    FN = (numRealizations * length(idTP)) - TP;

    FP = signif;
    FP(:,idTP) = [];
    FP = sum(FP,2);

    TN = (numRealizations * (numTargets-length(idTP))) - FP;

    sens(1,:) = TP ./ (TP + FN);
    spec(1,:) = TN ./ (TN + FP);
    accu(1,:) = (TN + TP) ./ (TN + TP + FN + FP);
    prec(1,:) = TP ./ (TP + FP);
    
    save('se_sp_ac_pr','sens','spec','accu','prec');
    
    

return;