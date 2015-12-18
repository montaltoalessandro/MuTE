function [pValue,fValue] = fTest(firstIdConditionalTerm,secondIdConditionalTerm,reconstructionError1,reconstructionError2)


    numTargets               = length(firstIdConditionalTerm);
    fValue                   = zeros(1,numTargets);
    pValue                   = zeros(1,numTargets);
    
    for i = 1 : numTargets
        firstRSS                          = sum(reconstructionError2{1,i}.^2);
        secondRSS                         = sum(reconstructionError1{1,i}.^2);
        numRestrictions                   = size(secondIdConditionalTerm{1,i},1) - size(firstIdConditionalTerm{1,i},1);
        oservationsWithoutCoeff           = length(reconstructionError1{1,i}) - size(secondIdConditionalTerm{1,i},1);
        fValue(1,i)                       = ((secondRSS - firstRSS)/numRestrictions)/(firstRSS/oservationsWithoutCoeff);
        pValue(1,i)                       = 1 - cca_cdff(fValue(1,i),numRestrictions,oservationsWithoutCoeff);
    end

return;

