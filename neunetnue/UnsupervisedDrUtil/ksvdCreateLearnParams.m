function paramsKSVD =ksvdCreateLearnParams(dictSize,numAtoms4SignalRange,runFields)
%function paramsKSVD =ksvdCreateLearnParams(numAtoms4SignalRange,runFields)
paramsKSVD.K                    = dictSize;
paramsKSVD.numIteration         = 50;
paramsKSVD.errorFlag            = 0;
paramsKSVD.preserveDCAtom       = 0;
paramsKSVD.InitializationMethod = 'DataElements';
paramsKSVD.displayProgress      = 1;
paramsKSVD.L                    = numAtoms4SignalRange; %round(numAtoms4SignalRange * dictSize);
paramsKSVD.runFields            = runFields;

return;