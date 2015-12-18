function [method] = mute_config()
%%%%configure mute with defaults and help text

 %%%%% last modified: 18-12-2015 by Frederik Van de Steen
 
 
 
%%%%general parameter defaults

gen_def.samplingRate.value = '1';
gen_def.samplingRate.text = 'samplingRate should be greater than 1 if data should be downsampled';


gen_def.pointsToDiscard.value = '0';
gen_def.pointsToDiscard.text = 'pointsToDiscard allows to discard a certain amount of points, starting from the last one';
gen_def.channels.value = '1:2';
gen_def.channels.text = 'channels is useful to select a subset of variables for a certain analysis. It is highly recommended to enter the series id from sorted in ascending order from left to right.';

gen_def.autoPairwiseTarDriv.value = '[1 1 1 1 1 1 1 1]';
gen_def.autoPairwiseTarDriv.text = 'autoPairwiseTarDriv takes into account the opportunity to investigate all the pair wise combinations of the variables chosen by means of channels. autoPairwiseTarDriv is then a vector with either 0 or 1 entries. The methods order shown at the beginning of this section has to be preserved.';

gen_def.handPairwiseTarDriv.value = '[0 0 0 0 0 0 0 0]';
gen_def.handPairwiseTarDriv.text = 'handPairwiseTarDriv is useful to when the user already know how many targets is going to choose for the analysis. If the the number of targets can be reshaped in a square matrix then it is worth setting as 1 the entriy of handPairwiseTarDriv corresponding to the method choosen. handPairwiseTarDriv is then a vector with either 0 or 1 entries. The methods order shown at the beginning of this section has to be preserved.';
gen_def.numProcessors.value = '1';
gen_def.numProcessors.text = 'Set the number of processors you can use to run your experiments changing value to the following variable';
gen_def.dataExtension.value = '.mat';
gen_def.dataExtension.text = 'dataExtension defines the file extension';


%%%%% binue defaults and text

binue.IdTargets.value                                    = '[]';
binue.IdTargets.text                                     = 'to be filled in';

binue.binUnifIdDrivers.value                                    = '[]';
binue.binUnifIdDrivers.text                                     ='to be filled in';

binue.binUnifIdOthersLagZero.value                              = '[]';
binue.binUnifIdOthersLagZero.text                               ='to be filled in';

binue.binUnifModelOrder.value                                   = '5';
binue.binUnifModelOrder.text                                    ='to be filled in';

binue.binUnifAnalysisType.value                                 = 'multiv';
binue.binUnifAnalysisType.text                                  ='to be filled in';

binue.binUnifQuantumlevels.value                                = '6';
binue.binUnifQuantumlevels.text                                 ='to be filled in';

binue.binUnifEntropyFun.value                                   ='@conditionalEntropy';
binue.binUnifEntropyFun.text                                    ='to be filled in';

binue.binUnifPreProcessingFun.value                             ='@quantization';
binue.binUnifPreProcessingFun.text                              ='to be filled in';

binue.binUnifCaseVect1.value                                    ='[1 0]';
binue.binUnifCaseVect1.text                                     ='to be filled in';

binue.binUnifCaseVect2.value                                    ='[1 1]';
binue.binUnifCaseVect2.text                                     ='to be filled in';

binue.binUnifNumSurrogates.value                                ='100';
binue.binUnifNumSurrogates.text                                 ='please specifiy the number of surrogates to be generated';

binue.binUnifAlphaPercentile.value                              ='0.05';
binue.binUnifAlphaPercentile.text                               ='to be filled in';

binue.binUnifTauMin.value                                       ='20';
binue.binUnifTauMin.text                                        ='to be filled in';

binue.binUnifGenerateCondTermFun.value                          = '@generateConditionalTerm';
binue.binUnifGenerateCondTermFun.text                           ='to be filled in';

binue.binUnifUsePresent.value                                   ='0';
binue.binUnifUsePresent.text                                    ='to be filled in';
binue.name='binue';


%%%


binnue.binNonUnifIdTargets.value                               = '[]';
binnue.binNonUnifIdTargets.text                                = 'to be filled in';

binnue.binNonUnifIdDrivers.value                               = '[]';
binnue.binNonUnifIdDrivers.text                                = 'to be filled in';

binnue.binNonUnifIdOthersLagZero.value                         = '[]';
binnue.binNonUnifIdOthersLagZero.text                          = 'to be filled in';

binnue.binNonUnifModelOrder.value                               = '5';
binnue.binNonUnifModelOrder.text                                = 'to be filled in';

binnue.binNonUnifAnalysisType.value                            = 'multiv';
binnue.binNonUnifAnalysisType.text                             = 'to be filled in';

binnue.binNonUnifQuantumlevels.value                           = '6';
binnue.binNonUnifQuantumlevels.text                            ='to be filled in';

binnue.binNonUnifEntropyFun.value                              = '@evaluateNonUniformEntropy';
binnue.binNonUnifEntropyFun.text                               = 'to be filled in';

binnue.binNonUnifPreProcessingFun.value                        = '@quantization';
binnue.binNonUnifPreProcessingFun.text                         = 'to be filled in';

binnue.binNonUnifCaseVect2.value                               = '[1 1]';
binnue.binNonUnifCaseVect2.text                                = 'to be filled in';

binnue.binNonUnifNumSurrogates.value                           = '100';
binnue.binNonUnifNumSurrogates.text                            = 'to be filled in';

binnue.binNonUnifAlphaPercentile.value                         = '0.05';
binnue.binNonUnifAlphaPercentile.text                          = 'to be filled in';

binnue.binNonUnifGenerateCondTermFun.value                     = '@generateConditionalTerm';
binnue.binNonUnifGenerateCondTermFun.text                      = 'to be filled in';

binnue.binNonUnifUsePresent.value                              = '0';
binnue.binNonUnifUsePresent.text                               = 'to be filled in';

binnue.binNonUnifScalpConduction.value                         = '0';
binnue.binNonUnifScalpConduction.text                          = 'to be filled in';
binnue.name='binnue';


linue.linUnifIdTargets.value                                   = '[]';
linue.linUnifIdTargets.text                                    = 'to be filled in';

linue.linUnifIdDrivers.value                                   = '[]';
linue.linUnifIdDrivers.text                                    = 'to be filled in';

linue.linUnifIdOthersLagZero.value                             = '[]';
linue.linUnifIdOthersLagZero.text                              = 'to be filled in';

linue.linUnifModelOrder.value                                  = '5';
linue.linUnifModelOrder.text                                   = 'to be filled in';

linue.linUnifAnalysisType.value                                = 'multiv';
linue.linUnifAnalysisType.text                                 = 'to be filled in';

linue.linUnifMinOrder.value                                    = '5';
linue.linUnifMinOrder.text                                     = 'to be filled in';

linue.linUnifMaxOrder.value                                    = '5';
linue.linUnifMaxOrder.text                                     = 'to be filled in';

linue.linUnifOrderCriterion.value                              = 'bayesian';
linue.linUnifOrderCriterion.text                               = 'to be filled in';

linue.linUnifEntropyFun.value                                  = '@linearEntropy';
linue.linUnifEntropyFun.text                                   = 'to be filled in';

linue.linUnifCaseVect1.value                                   = '[1 0]';
linue.linUnifCaseVect1.text                                    = 'to be filled in';

linue.linUnifCaseVect2.value                                   = '[1 1]';
linue.linUnifCaseVect2.text                                    = 'to be filled in';

linue.linUnifGenerateCondTermFun.value                         = '@generateConditionalTerm';
linue.linUnifGenerateCondTermFun.text                          = 'to be filled in';

linue.linUnifUsePresent.value                                  = '0';
linue.linUnifUsePresent.text                                   = 'to be filled in';
linue.name='linue';


linnue.linNonUnifIdTargets.value                                = '[]';
linnue.linNonUnifIdTargets.text                                 = 'to be filled in';

linnue.linNonUnifIdDrivers.value                                = '[]';
linnue.linNonUnifIdDrivers.text                                 = 'to be filled in';

linnue.linNonUnifIdOthersLagZero.value                          = '[]';
linnue.linNonUnifIdOthersLagZero.text                           = 'to be filled in';

linnue.linNonUnifModelOrder.value                               ='5';
linnue.linNonUnifModelOrder.text                                ='to be filled in';

linnue.linNonUnifAnalysisType.value                             ='multiv';
linnue.linNonUnifAnalysisType.text                              ='to be filled in';

linnue.linNonUnifEntropyFun.value                               = '@evaluateLinearNonUniformEntropy';
linnue.linNonUnifEntropyFun.text                                = 'to be filled in';

linnue.linNonUnifCaseVect.value                                 = '[1 1]';
linnue.linNonUnifCaseVect.text                                  = 'to be filled in';

linnue.linNonUnifNumSurrogates.value                            = '100';
linnue.linNonUnifNumSurrogates.text                             = 'to be filled in';

linnue.linNonUnifAlphaPercentile.value                          ='0.05';
linnue.linNonUnifAlphaPercentile.text                           ='to be filled in';

linnue.linNonUnifGenerateCondTermFun.value                      ='@generateConditionalTerm';
linnue.linNonUnifGenerateCondTermFun.text                       ='to be filled in';

linnue.linNonUnifUsePresent.value                               = '0';
linnue.linNonUnifUsePresent.text                                = 'to be filled in';
   linnue.name='linnue';


nnue.nearNeighUnifIdTargets.value                              = '[]';
nnue.nearNeighUnifIdTargets.text                              = 'to be filled in';

nnue.nearNeighUnifIdDrivers.value                             = '[]';
nnue.nearNeighUnifIdDrivers.text                              = 'to be filled in';

nnue.nearNeighUnifIdOthersLagZero.value                        = '[]';
nnue.nearNeighUnifIdOthersLagZero.text                        = 'to be filled in';

nnue.nearNeighUnifModelOrder.value                             = '5';
nnue.nearNeighUnifModelOrder.text                             = 'to be filled in';

nnue.nearNeighUnifAnalysisType.value                           = 'multiv';
nnue.nearNeighUnifAnalysisType.text                           = 'to be filled in';

nnue.nearNeighUnifCaseVect.value                               = '[1 1]';
nnue.nearNeighUnifCaseVect.text                               = 'to be filled in';

nnue.nearNeighUnifNumSurrogates.value                          = '100';
nnue.nearNeighUnifNumSurrogates.text                          = 'to be filled in';

nnue.nearNeighUnifMetric.value                                 = 'maximum';
nnue.nearNeighUnifMetric.text                                 ='to be filled in'; 

nnue.nearNeighUnifNumNearNei.value                             = '10';
nnue.nearNeighUnifNumNearNei.text                             = 'to be filled in';
w = what('nnnue');


nnue.nearNeighUnifFuncDir.value                                = [w.path(1:end-5) 'OpenTSTOOL/tstoolbox/mex/mexa64/'];
nnue.nearNeighUnifFuncDir.text                                = 'to be filled in';

w = what('nnnue');

nnue.nearNeighUnifHomeDir.value                                = w.path(1:end-5);
nnue.nearNeighUnifHomeDir.text                                = 'to be filled in';

nnue.nearNeighUnifAlphaPercentile.value                        = '0.05';
nnue.nearNeighUnifAlphaPercentile.text                        = 'to be filled in';

nnue.nearNeighUnifTauMin.value                                 = '10';
nnue.nearNeighUnifTauMin.text                                 = 'to be filled in';

nnue.nearNeighUnifGenerateCondTermFun.value                    = '@generateConditionalTerm';
nnue.nearNeighUnifGenerateCondTermFun.text                   ='to be filled in'; 

nnue.nearNeighUnifUsePresent.value                             = '0';
nnue.nearNeighUnifUsePresent.text                             = 'to be filled in';
nnue.name='nnue';



                                             
nnnue.nearNeighNonUnifIdTargets.value                          = '[]';
nnnue.nearNeighNonUnifIdTargets.text                           = 'to be filled in';

nnnue.nearNeighNonUnifIdDrivers.value                          = '[]';
nnnue.nearNeighNonUnifIdDrivers.text                           = 'to be filled in';

nnnue.nearNeighNonUnifIdOthersLagZero.value                    = '[]';
nnnue.nearNeighNonUnifIdOthersLagZero.text                     = 'to be filled in';

nnnue.nearNeighNonUnifModelOrder.value                         = '5';
nnnue.nearNeighNonUnifModelOrder.text                          = 'to be filled in';

nnnue.nearNeighNonUnifAnalysisType.value                       = 'multiv';
nnnue.nearNeighNonUnifAnalysisType.text                        = 'to be filled in';

nnnue.nearNeighNonUnifCaseVect.value                           = '[1 1]';
nnnue.nearNeighNonUnifCaseVect.text                            = 'to be filled in';

nnnue.nearNeighNonUnifNumSurrogates.value                      = '100';
nnnue.nearNeighNonUnifNumSurrogates.text                       = 'to be filled in';

nnnue.nearNeighNonUnifMetric.value                             = 'maximum';
nnnue.nearNeighNonUnifMetric.text                              = 'to be filled in';

nnnue.nearNeighNonUnifNumNearNei.value                         = '10';
nnnue.nearNeighNonUnifNumNearNei.text                          = 'to be filled in';

nnnue.nearNeighNonUnifInfoTransCriterionFun.value              = '@nearNeiConditionalMutualInformation';
nnnue.nearNeighNonUnifInfoTransCriterionFun.text               = 'to be filled in';

nnnue.nearNeighNonUnifSurroTestFun.value                       = '@evalNearNeiTestSurrogates2rand';
nnnue.nearNeighNonUnifSurroTestFun.text                        = 'to be filled in';

nnnue.nearNeighNonUnifFuncDir.value                            = [w.path(1:end-5) 'OpenTSTOOL/tstoolbox/mex/mexa64/'];
nnnue.nearNeighNonUnifFuncDir.text                             = 'to be filled in';

nnnue.nearNeighNonUnifHomeDir.value                            = w.path(1:end-5);
nnnue.nearNeighNonUnifHomeDir.text                             = 'to be filled in';

nnnue.nearNeighNonUnifAlphaPercentile.value                    = '0.05';
nnnue.nearNeighNonUnifAlphaPercentile.text                     = 'to be filled in';

nnnue.nearNeighNonUnifGenerateCondTermFun.value                = '@generateConditionalTerm';
nnnue.nearNeighNonUnifGenerateCondTermFun.text                 = 'to be filled in';

nnnue.nearNeighNonUnifUsePresent.value                         = '0';
nnnue.nearNeighNonUnifUsePresent.text                          = 'to be filled in';
nnnue.name='nnnue';

neunetue.nnueIdTargets.value                                        = '[]';
neunetue.nnueIdTargets.text                                         = 'to be filled in';

neunetue.nnueIdDrivers.value                                        ='[]'; 
neunetue.nnueIdDrivers.text                                         = 'to be filled in';

neunetue.nnueIdOtherLagZero.value                                   = '[]';
neunetue.nnueIdOtherLagZero.text                                    = 'to be filled in';

neunetue.nnueModelOrder.value                                       = '5';
neunetue.nnueModelOrder.text                                        = 'to be filled in';

neunetue.nnuesecondTermCaseVect.value                               = '[1 1]';
neunetue.nnuesecondTermCaseVect.text                                = 'to be filled in';

neunetue.nnueAnalysisType.value                                     = 'multiv';
neunetue.nnueAnalysisType.text                                      = 'to be filled in';

neunetue.nnueEta.value                                              = '[]';
neunetue.nnueEta.text                                               = 'to be filled in';

neunetue.nnueAlpha.value                                            = '[]';
neunetue.nnueAlpha.text                                             = 'to be filled in';

neunetue.nnueActFunc.value                                          = '@sigmoid @identity';
neunetue.nnueActFunc.text                                           = 'to be filled in';
% [token, remain] = strtok(tmp)
% remain(2:end)

% str2func(remain(2:end))

neunetue.nnueNumEpochs.value                                        = '30';
neunetue.nnueNumEpochs.text                                         = 'to be filled in';

neunetue.nnueBias.value                                            = '0';
neunetue.nnueBias.text                                              = 'to be filled in';

neunetue.nnueEpochs.value                                           = '4000';
neunetue.nnueEpochs.text                                            = 'to be filled in';

neunetue.nnueDividingPoint.value                                    = '2/3';
neunetue.nnueDividingPoint.text                                     = 'to be filled in';

neunetue.nnueValStep.value                                          = '15';
neunetue.nnueValStep.text                                           = 'to be filled in';

neunetue.nnueValThreshold.value                                     = '0.6';
neunetue.nnueValThreshold.text                                      = 'to be filled in';

neunetue.nnueLearnAlg.value                                         = '@resilientBackPropagation';
neunetue.nnueLearnAlg.text                                          = 'to be filled in';

neunetue.nnueRbpIncrease.value                                      = '1.1';
neunetue.nnueRbpIncrease.text                                       = 'to be filled in';

neunetue.nnueRbpDescrease.value                                     = '0.9';
neunetue.nnueRbpDescrease.text                                      = 'to be filled in';

neunetue.nnueRangeW.value                                           = '1';
neunetue.nnueRangeW.text                                            = 'to be filled in';

neunetue.nnueCoeffHidNodes.value                                    = '0.3';
neunetue.nnueCoeffHidNodes.text                                     = 'to be filled in';

neunetue.nnueNumSurrogates.value                                    = '100';
neunetue.nnueNumSurrogates.text                                     = 'to be filled in';

neunetue.nnueTauMin.value                                           = '20';
neunetue.nnueTauMin.text                                            = 'to be filled in';

neunetue.nnueAlphaPercentile.value                                  = '0.05';
neunetue.nnueAlphaPercentile.text                                   = 'to be filled in';

neunetue.nnueGenCondTermFun.value                                   = '@generateConditionalTerm';
neunetue.nnueGenCondTermFun.text                                    = 'to be filled in';

neunetue.nnueUsePresent.value                                       = '0';
neunetue.nnueUsePresent.text                                        = 'to be filled in';
neunetue.name = 'neunetue';



                                       
neunetnue.nnData.value                                            = '[]';
neunetnue.nnData.text                                             = 'to be filled in';

neunetnue.nnIdTargets.value                                        ='[]'; 
neunetnue.nnIdTargets.text                                        = 'to be filled in';

neunetnue.nnIdDrivers.value                                        = '[]';
neunetnue.nnIdDrivers.text                                       = 'to be filled in';

neunetnue.nnIdOtherLagZero.value                                   = '[]';
neunetnue.nnIdOtherLagZero.text                                   = 'to be filled in';

neunetnue.nnModelOrder.value                                       ='5'; 
neunetnue.nnModelOrder.text                                       = 'to be filled in'; 

neunetnue.nnFirstTermCaseVect.value                                = '[1 0]';
neunetnue.nnFirstTermCaseVect.text                                = 'to be filled in';

neunetnue.nnSecondTermCaseVect.value                               = '[1 1]';
neunetnue.nnSecondTermCaseVect.text                               = 'to be filled in';

neunetnue.nnAnalysisType.value                                     = 'multiv';
neunetnue.nnAnalysisType.text                                     = 'to be filled in';

neunetnue.nnEta.value                                              = '[]';
neunetnue.nnEta.text                                              = 'to be filled in';

neunetnue.nnAlpha.value                                            = '[]';
neunetnue.nnAlpha.text                                            = 'to be filled in';

neunetnue.nnActFunc.value                                          = '@sigmoid @identity';
neunetnue.nnActFunc.text                                          = 'to be filled in';

neunetnue.nnNumEpochs.value                                        = '30';
neunetnue.nnNumEpochs.text                                        = 'to be filled in';

neunetnue.nnBias.value                                             = '0';
neunetnue.nnBias.text                                             = 'to be filled in';

neunetnue.nnEpochs.value                                           = '4000';
neunetnue.nnEpochs.text                                           = 'to be filled in';

neunetnue.nnThreshold.value                                        = '0.008';
neunetnue.nnThreshold.text                                        = 'to be filled in';

neunetnue.nnDividingPoint.value                                    = '2/3';
neunetnue.nnDividingPoint.text                                    = 'to be filled in';

neunetnue.nnValStep.value                                          = '15';
neunetnue.nnValStep.text                                         = 'to be filled in';

neunetnue.nnValThreshold.value                                     = '0.6';
neunetnue.nnValThreshold.text                                    = 'to be filled in';

neunetnue.nnLearnAlg.value                                         = '@resilientBackPropagation';
neunetnue.nnLearnAlg.text                                         = 'to be filled in';

neunetnue.nnRbpIncrease.value                                      = '1.1';
neunetnue.nnRbpIncrease.text                                      = 'to be filled in';

neunetnue.nnRbpDescrease.value                                     = '0.9';
neunetnue.nnRbpDescrease.text                                     = 'to be filled in';

neunetnue.nnRangeW.value                                           = '1';
neunetnue.nnRangeW.text                                           = 'to be filled in';

neunetnue.nnCoeffHidNodes.value                                    = '0.3';
neunetnue.nnCoeffHidNodes.text                                    = 'to be filled in';

neunetnue.nnGenCondTermFun.value                                   = '@generateConditionalTerm';
neunetnue.nnGenCondTermFun.text                                  = 'to be filled in';

neunetnue.nnUsePresent.value                                       = '0';
neunetnue.nnUsePresent.text                                       = 'to be filled in';

neunetnue.name='neunetnue';
method.binnue =binnue;
method.binue =binue;
method.linue =linue;
method.linnue =linnue;
method.nnnue =nnnue;
method.nnue =nnue;
method.neunetnue =neunetnue;
method.neunetue =neunetue;
method.gen_def = gen_def;
end