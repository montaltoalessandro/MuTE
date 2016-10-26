function [method] = mute_config()
%%%%configure mute with defaults and help text

 %%%%% last modified: 27-01-2015 by Frederik Van de Steen
 
 
 
%%%%general parameter defaults

gen_def.samplingRate.value = '1';
gen_def.samplingRate.text = 'samplingRate should be greater than 1 if data should be downsampled';


gen_def.pointsToDiscard.value = '0';
gen_def.pointsToDiscard.text = 'pointsToDiscard allows to discard a certain amount of points, starting from the last one';
gen_def.channels.value = '1:2';
gen_def.channels.text = 'channels is useful to select a subset of variables for a certain analysis. It is highly recommended to enter the series id in ascending order from left to right.';

gen_def.autoPairwiseTarDriv.value = '[1 1 1 1 1 1 1 1]';
gen_def.autoPairwiseTarDriv.text = 'autoPairwiseTarDriv takes into accoun the opportunity to investigate all the pair wise combinations of the variables chosen by means of channels. autoPairwiseTarDriv is then a vector with either 0 or 1 entries. It is recommended to leave the default. See the website for more information.';

gen_def.handPairwiseTarDriv.value = '[0 0 0 0 0 0 0 0]';
gen_def.handPairwiseTarDriv.text = 'handPairwiseTarDriv is useful to when the user already know how many targets is going to choose for the analysis. If the the number of targets can be reshaped in a square matrix then it is worth setting as 1 the entriy of handPairwiseTarDriv corresponding to the method choosen. handPairwiseTarDriv is then a vector with either 0 or 1 entries. It is recommended to leave the default. See the website for more information.';
gen_def.numProcessors.value = '1';
gen_def.numProcessors.text = 'Set the number of processors you can use to run your experiments.';
gen_def.dataExtension.value = '.mat';
gen_def.dataExtension.text = 'dataExtension defines the file extension';

gen_def.datafilename.value = [];
gen_def.datafilename.text = 'dataFileName takes the part of the name file common to all the files involved in the analysis.';
gen_def.datalabel.value = '[]';
gen_def.datalabel.text = 'dataLabel is useful to distinguish files. If no label is required set dataLabel as an empty string.';
gen_def.datafolder.value = [];
gen_def.datafolder.text = 'datafolder refers to the folder were the data to be analysed is stored';




%%%%% binue defaults and text

binue.IdTargets.value                                    = '[]';
binue.IdTargets.text                                     = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

binue.IdDrivers.value                                    = '[]';
binue.IdDrivers.text                                     ='idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

binue.IdOthersLagZero.value                              = '[]';
binue.IdOthersLagZero.text                               ='idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

binue.ModelOrder.value                                   = '5';
binue.ModelOrder.text                                    ='modelOrder can be a vector indicating how many past states should be taken into account for each series chosen for the analisys by means of channels. If modelOrder is an integer the same amount of past states is considered for all the series in channels.';

binue.multi_bivAnalysis.value                                 = 'multiv';
binue.multi_bivAnalysis.text                                  ='multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

binue.Quantumlevels.value                                = '6';
binue.Quantumlevels.text                                 ='Quantumlevelsis an integer where the number of quantum levels is specified';

binue.EntropyFun.value                                   ='@conditionalEntropy';
binue.EntropyFun.text                                    ='EntropyFun is a pointer to the function that will evaluate the entropy';

binue.PreProcessingFun.value                             ='@quantization';
binue.PreProcessingFun.text                              ='PreProcessingFun is a pointer to the function needed to pre-process of the data';

binue.firstTermCaseVect.value                                    ='[1 0]';
binue.firstTermCaseVect.text                                     ='firstTermCaseVect is a vector where the first position refers to idTargets, the second one refers to idDrivers ([1 0]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

binue.secondTermCaseVect.value                                    ='[1 1]';
binue.secondTermCaseVect.text                                     ='secondTermCaseVect is a vector where the first position refers to idTargets, the second one refers to idDrivers ([1 1]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

binue.NumSurrogates.value                                ='100';
binue.NumSurrogates.text                                 ='NumSurrogates is the number of surrogates necessary to asses the statistical threshold.';

binue.AlphaPercentile.value                              ='0.05';
binue.AlphaPercentile.text                               ='AlphaPercentile refers the the significance level for rejecting the null hypothesis';

binue.TauMin.value                                       ='20';
binue.TauMin.text                                        ='Taumin is an integer which indicates number of shifts to produce a surrogate ';

binue.GenerateCondTermFun.value                          = '@generateConditionalTerm';
binue.GenerateCondTermFun.text                           ='genCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.';

binue.UsePresent.value                                   ='0';
binue.UsePresent.text                                    ='usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';
binue.name='binue';


%%%


binnue.IdTargets.value                               = '[]';
binnue.IdTargets.text                                = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

binnue.IdDrivers.value                               = '[]';
binnue.IdDrivers.text                                = 'idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

binnue.IdOthersLagZero.value                         = '[]';
binnue.IdOthersLagZero.text                          = 'idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

binnue.ModelOrder.value                               = '5';
binnue.ModelOrder.text                                = 'modelOrder can be a vector indicating how many past states should be taken into account for each series chosen for the analisys by means of channels. If modelOrder is an integer the same amount of past states is considered for all the series in channels.';

binnue.multi_bivAnalysis.value                            = 'multiv';
binnue.multi_bivAnalysis.text                             = 'multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

binnue.Quantumlevels.value                           = '6';
binnue.Quantumlevels.text                            ='Quantumlevelsis an integer where the number of quantum levels is specified';

binnue.EntropyFun.value                              = '@evaluateNonUniformEntropy';
binnue.EntropyFun.text                               = 'EntropyFun is a pointer to the function that will evaluate the entropy';

binnue.PreProcessingFun.value                        = '@quantization';
binnue.PreProcessingFun.text                         = 'PreProcessingFun is a pointer to the function needed to pre-process of the data';

binnue.secondTermCaseVect.value                               = '[1 1]';
binnue.secondTermCaseVect.text                                = 'secondTermCaseVect is a vector: the first position refers to idTargets, the second one refers to idDrivers ([1 1]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

binnue.NumSurrogates.value                           = '100';
binnue.NumSurrogates.text                            = 'NumSurrogates is the number of surrogates necessary to asses the statistical threshold.';

binnue.AlphaPercentile.value                         = '0.05';
binnue.AlphaPercentile.text                          = 'AlphaPercentile refers the the significance level.';

binnue.GenerateCondTermFun.value                     = '@generateConditionalTerm';
binnue.GenerateCondTermFun.text                      = 'genCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.';

binnue.UsePresent.value                              = '0';
binnue.UsePresent.text                               = 'usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';

binnue.ScalpConduction.value                         = '0';
binnue.ScalpConduction.text                          = 'Leave this at 0 unless you know what you are doing. Please go to the website for more info';
binnue.name='binnue';


linue.IdTargets.value                                   = '[]';
linue.IdTargets.text                                    = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

linue.IdDrivers.value                                   = '[]';
linue.IdDrivers.text                                    = 'idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

linue.IdOthersLagZero.value                             = '[]';
linue.IdOthersLagZero.text                              = 'idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

linue.ModelOrder.value                                  = '5';
linue.ModelOrder.text                                   = 'modelOrder can be a vector indicating how many past states should be taken into account for each series chosen for the analisys by means of channels. If modelOrder is an integer the same amount of past states is considered for all the series in channels.';

linue.multi_bivAnalysis.value                                = 'multiv';
linue.multi_bivAnalysis.text                                 = 'multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

linue.MinOrder.value                                    = '5';
linue.MinOrder.text                                     = 'MinOrder is an integer indicating the lower bound of the interval in which arfit can look for the best model order able to fit the data';

linue.MaxOrder.value                                    = '5';
linue.MaxOrder.text                                     = 'MaxOrder is an integer indicating the upper bound of the interval in which arfit can look for the best model order able to fit the data';

linue.OrderCriterion.value                              = 'bayesian';
linue.OrderCriterion.text                               = 'OrderCriterion is a string specifying the order selection criterion for arfit. If orderCriterion is not set to ‘bayesian’, the Akaike’s Final Prediction Error will be chosen as selection criterion';

linue.EntropyFun.value                                  = '@linearEntropy';
linue.EntropyFun.text                                   = 'EntropyFun is a pointer to the function that will evaluate the entropy';

linue.firstTermCaseVect.value                                   = '[1 0]';
linue.firstTermCaseVect.text                                    = 'firstTermCaseVect is a vector where the first position refers to idTargets, the second one refers to idDrivers ([1 0]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

linue.secondTermCaseVect.value                                   = '[1 1]';
linue.secondTermCaseVect.text                                    = 'secondTermCaseVect is a vector: the first position refers to idTargets, the second one refers to idDrivers ([1 1]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

linue.GenerateCondTermFun.value                         = '@generateConditionalTerm';
linue.GenerateCondTermFun.text                          = 'genCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.';

linue.UsePresent.value                                  = '0';
linue.UsePresent.text                                   = 'usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';
linue.name='linue';


linnue.IdTargets.value                                = '[]';
linnue.IdTargets.text                                 = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

linnue.IdDrivers.value                                = '[]';
linnue.IdDrivers.text                                 = 'idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

linnue.IdOthersLagZero.value                          = '[]';
linnue.IdOthersLagZero.text                           = 'idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

linnue.ModelOrder.value                               ='5';
linnue.ModelOrder.text                                ='modelOrder can be a vector indicating how many past states should be taken into account for each series chosen for the analisys by means of channels. If modelOrder is an integer the same amount of past states is considered for all the series in channels.';

linnue.multi_bivAnalysis.value                             ='multiv';
linnue.multi_bivAnalysis.text                              ='multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

linnue.EntropyFun.value                               = '@evaluateLinearNonUniformEntropy';
linnue.EntropyFun.text                                = 'EntropyFun is a pointer to the function that will evaluate the entropy';

linnue.secondTermCaseVect.value                                 = '[1 1]';
linnue.secondTermCaseVect.text                                  = 'secondTermCaseVect is a vector: the first position refers to idTargets, the second one refers to idDrivers ([1 1]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

linnue.NumSurrogates.value                            = '100';
linnue.NumSurrogates.text                             = 'NumSurrogates is the number of surrogates necessary to asses the statistical threshold.';

linnue.AlphaPercentile.value                          ='0.05';
linnue.AlphaPercentile.text                           ='AlphaPercentile refers the the significance level.';

linnue.GenerateCondTermFun.value                      ='@generateConditionalTerm';
linnue.GenerateCondTermFun.text                       ='genCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.';

linnue.UsePresent.value                               = '0';
linnue.UsePresent.text                                = 'usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';
   linnue.name='linnue';


nnue.IdTargets.value                              = '[]';
nnue.IdTargets.text                              = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

nnue.IdDrivers.value                             = '[]';
nnue.IdDrivers.text                              = 'idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

nnue.IdOthersLagZero.value                        = '[]';
nnue.IdOthersLagZero.text                        = 'idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

nnue.ModelOrder.value                             = '5';
nnue.ModelOrder.text                             = 'can be a vector indicating how many past states should be taken into account for each series chosen for the analisys by means of channels. If modelOrder is an integer the same amount of past states is considered for all the series in channels.';

nnue.multi_bivAnalysis.value                           = 'multiv';
nnue.multi_bivAnalysis.text                           = 'multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

nnue.firstTermCaseVect.value                               = '[1 1]';
nnue.firstTermCaseVect.text                               = 'firstTermCaseVect is a vector where the first position refers to idTargets, the second one refers to idDrivers ([1 0]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

nnue.NumSurrogates.value                          = '100';
nnue.NumSurrogates.text                          = 'NumSurrogates is the number of surrogates necessary to asses the statistical threshold.';

nnue.Metric.value                                 = 'maximum';
nnue.Metric.text                                 ='it is possible to set the metric (either ‘euclidian’ or ‘maximum’) used to evaluate the distance in the phase space'; 

nnue.NumNearNei.value                             = '10';
nnue.NumNearNei.text                             = 'NumNearNei is the number of nearest neighbors to compute';
w = what('nnnue');


nnue.FuncDir.value                                = [w.path(1:end-5) 'OpenTSTOOL/tstoolbox/mex/mexa64/'];
nnue.FuncDir.text                                = 'FuncDir is a string the refers to the mex files path. Normally this is done automatically. ';

w = what('nnnue');

nnue.HomeDir.value                                = w.path(1:end-5);
nnue.HomeDir.text                                = 'HomeDir is a string specifying the MuTE path. This is done automatically';

nnue.AlphaPercentile.value                        = '0.05';
nnue.AlphaPercentile.text                        = 'AlphaPercentile refers the the significance level.';

nnue.TauMin.value                                 = '10';
nnue.TauMin.text                                 = 'TauMin is the number of shifts to produce a surrogate';

nnue.GenerateCondTermFun.value                    = '@generateConditionalTerm';
nnue.GenerateCondTermFun.text                   ='GenerateCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.'; 

nnue.UsePresent.value                             = '0';
nnue.UsePresent.text                             = 'usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';
nnue.name='nnue';



                                             
nnnue.IdTargets.value                          = '[]';
nnnue.IdTargets.text                           = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

nnnue.IdDrivers.value                          = '[]';
nnnue.IdDrivers.text                           = 'idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

nnnue.IdOthersLagZero.value                    = '[]';
nnnue.IdOthersLagZero.text                     = 'idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

nnnue.ModelOrder.value                         = '5';
nnnue.ModelOrder.text                          = 'can be a vector indicating how many past states should be taken into account for each series chosen for the analisys by means of channels. If modelOrder is an integer the same amount of past states is considered for all the series in channels.';

nnnue.multi_bivAnalysis.value                       = 'multiv';
nnnue.multi_bivAnalysis.text                        = 'multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

nnnue.firstTermCaseVect.value                           = '[1 1]';
nnnue.firstTermCaseVect.text                            = 'firstTermCaseVect is a vector where the first position refers to idTargets, the second one refers to idDrivers ([1 0]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

nnnue.NumSurrogates.value                      = '100';
nnnue.NumSurrogates.text                       = 'NumSurrogates is the number of surrogates necessary to asses the statistical threshold.';

nnnue.Metric.value                             = 'maximum';
nnnue.Metric.text                              = 'it is possible to set the metric (either ‘euclidian’ or ‘maximum’) used to evaluate the distance in the phase space';

nnnue.NumNearNei.value                         = '10';
nnnue.NumNearNei.text                          = 'NumNearNei is the number of nearest neighbors to compute';

nnnue.InfoTransCriterionFun.value              = '@nearNeiConditionalMutualInformation';
nnnue.InfoTransCriterionFun.text               = 'informationTransCriterionFun is a pointer that refers to the function needed to evaluate the conditional mutual information;';

nnnue.SurroTestFun.value                       = '@evalNearNeiTestSurrogates2rand';
nnnue.SurroTestFun.text                        = 'surrogatesTestFun is a pointer that refers to the function that performs the surrogates test;';

nnnue.FuncDir.value                            = [w.path(1:end-5) 'OpenTSTOOL/tstoolbox/mex/mexa64/'];
nnnue.FuncDir.text                             = 'FuncDir is a string the refers to the mex files path. Normally this is done automatically.';

nnnue.HomeDir.value                            = w.path(1:end-5);
nnnue.HomeDir.text                             = 'HomeDir is a string specifying the MuTE path. This is done automatically';

nnnue.AlphaPercentile.value                    = '0.05';
nnnue.AlphaPercentile.text                     = 'AlphaPercentile refers the the significance level.';

nnnue.GenerateCondTermFun.value                = '@generateConditionalTerm';
nnnue.GenerateCondTermFun.text                 = 'genCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.';

nnnue.UsePresent.value                         = '0';
nnnue.UsePresent.text                          = 'usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';
nnnue.name='nnnue';

neunetue.IdTargets.value                                        = '[]';
neunetue.IdTargets.text                                         = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

neunetue.IdDrivers.value                                        ='[]'; 
neunetue.IdDrivers.text                                         = 'idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

neunetue.IdOtherLagZero.value                                   = '[]';
neunetue.IdOtherLagZero.text                                    = 'idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

neunetue.ModelOrder.value                                       = '5';
neunetue.ModelOrder.text                                        = 'can be a vector indicating how many past states should be taken into account for each series chosen for the analisys by means of channels. If modelOrder is an integer the same amount of past states is considered for all the series in channels.';

neunetue.secondTermCaseVect.value                               = '[1 1]';
neunetue.secondTermCaseVect.text                                = 'secondTermCaseVect is a vector: the first position refers to idTargets, the second one refers to idDrivers ([1 1]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

neunetue.multi_bivAnalysis.value                                     = 'multiv';
neunetue.multi_bivAnalysis.text                                      = 'multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

neunetue.Eta.value                                              = '[]';
neunetue.Eta.text                                               = 'Eta is the learning rate to update the weights with gradient descent and gradient descent with momentum. This parameter is not useful to set the method appeared in literature. Nonetheless, it might be useful for further analyses considering a variation of the published method.';

neunetue.Alpha.value                                            = '[]';
neunetue.Alpha.text                                             = 'Alpha is a parameter required in gradient descent with momentum. This parameter is not useful to set the method appeared in literature. Nonetheless, it might be useful for further analyses considering a variation of the published method.';

neunetue.ActFunc.value                                          = '@sigmoid @identity';
neunetue.ActFunc.text                                           = 'ActFuncis a cell array of pointers: it contains pointers to functions that are used as activation functions. There must be (number hidden layers + output layer) number of entries specifying the activation function for each layer';

neunetue.NumEpochs.value                                        = '30';
neunetue.NumEpochs.text                                         = 'NumEpochs is the number of training epochs';

neunetue.Bias.value                                            = '0';
neunetue.Bias.text                                              = 'Bias allows to take into account the bias if it is set as 1. If bias nodes are not required, bias has to be set as 0';

neunetue.candidateEpochs.value                                           = '4000';
neunetue.candidateEpochs.text                                            = 'candidateEpochs is the number of maximum iterations needed to train the network with the current candidate. It is used in the outer while of the non-uniform wrapper';

neunetue.DividingPoint.value                                    = '2/3';
neunetue.DividingPoint.text                                     = 'Dividingpoint is the amount of points used to train the networks. It is expressed as the fraction of the data set number of points';

neunetue.ValStep.value                                          = '15';
neunetue.ValStep.text                                           = 'ValStep is the number of iterations after which the validation phase takes place';

neunetue.ValThreshold.value                                     = '0.6';
neunetue.ValThreshold.text                                      = 'ValThreshold is the threshold needed during the validation phase';

neunetue.LearnAlg.value                                         = '@resilientBackPropagation';
neunetue.LearnAlg.text                                          = 'LearnAlg points to the function used as learning algorithm';

neunetue.RbpIncrease.value                                      = '1.1';
neunetue.RbpIncrease.text                                       = 'Please keep the default unless you now what you are doing. For more information visit the website or/and contact the authors';

neunetue.RbpDescrease.value                                     = '0.9';
neunetue.RbpDescrease.text                                      = 'Please keep the default unless you now what you are doing. For more information visit the website or/and contact the authors';

neunetue.RangeW.value                                           = '1';
neunetue.RangeW.text                                            = 'RangeW represents the range of values assumed by the weights when initialized. If rangeW is set as 1, the weights will be initialized between -1 and 1.';

neunetue.CoeffHidNodes.value                                    = '0.3';
neunetue.CoeffHidNodes.text                                     = 'CoeffHidNodes is the percentage of hidden nodes with respect to the amount of available candidates';

neunetue.NumSurrogates.value                                    = '100';
neunetue.NumSurrogates.text                                     = 'NumSurrogates is the number of surrogates necessary to asses the statistical threshold.';

neunetue.TauMin.value                                           = '20';
neunetue.TauMin.text                                            = 'Taumin number of shifts to produce a surrogate';

neunetue.AlphaPercentile.value                                  = '0.05';
neunetue.AlphaPercentile.text                                   = 'AlphaPercentile refers the the significance level.';

neunetue.GenCondTermFun.value                                   = '@generateConditionalTerm';
neunetue.GenCondTermFun.text                                    = 'genCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.';

neunetue.UsePresent.value                                       = '0';
neunetue.UsePresent.text                                        = 'usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';
neunetue.name = 'neunetue';



                                       
neunetnue.Data.value                                            = '[]';
neunetnue.Data.text                                             = 'data arranged differently with respect to data used by the other methods. It might be useful to arrange data in order to line up the realizations that the other methods would analyze separately';

neunetnue.IdTargets.value                                        ='[]'; 
neunetnue.IdTargets.text                                        = 'IdTargets is a row vector with entries the series id chosen as targets of the analysis. It may contain repeated indeces';

neunetnue.IdDrivers.value                                        = '[]';
neunetnue.IdDrivers.text                                       = 'idDrivers is a matrix with columns the series id whose influence on the corresponding target column wise in idTarget is going to be evaluated.';

neunetnue.IdOtherLagZero.value                                   = '[]';
neunetnue.IdOtherLagZero.text                                   = 'idOtherLagZero is a matrix with columns the series id chosen among the conditioning variables for that analysis that should be taken into account with the instantaneous effect.';

neunetnue.ModelOrder.value                                       ='5'; 
neunetnue.ModelOrder.text                                       = 'multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.'; 

neunetnue.firstTermCaseVect.value                                = '[1 0]';
neunetnue.firstTermCaseVect.text                                = 'firstTermCaseVect is a vector where the first position refers to idTargets, the second one refers to idDrivers ([1 0]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

neunetnue.SecondTermCaseVect.value                               = '[1 1]';
neunetnue.SecondTermCaseVect.text                               = 'secondTermCaseVect is a vector: the first position refers to idTargets, the second one refers to idDrivers ([1 1]). Set 1 according to wich candidates you want to take into account. It is strongly recommended to leave firstTermCaseVect and secondTermCaseVect as they are.';

neunetnue.multi_bivAnalysis.value                                     = 'multiv';
neunetnue.multi_bivAnalysis.text                                     = 'multi_bivAnalysis is a string containing either biv or multiv according to whether perform a bivariate or multivariate analysis respectively.';

neunetnue.Eta.value                                              = '[]';
neunetnue.Eta.text                                              = 'Alpha is a parameter required in gradient descent with momentum. This parameter is not useful to set the method appeared in literature. Nonetheless, it might be useful for further analyses considering a variation of the published method.';

neunetnue.Alpha.value                                            = '[]';
neunetnue.Alpha.text                                            = 'Alpha is a parameter required in gradient descent with momentum. This parameter is not useful to set the method appeared in literature. Nonetheless, it might be useful for further analyses considering a variation of the published method.';

neunetnue.ActFunc.value                                          = '@sigmoid @identity';
neunetnue.ActFunc.text                                          = 'ActFunc is cell array of pointers: it contains pointers to functions that are used as activation functions. There must be (number hidden layers + output layer) number of entries specifying the activation function for each layer';

neunetnue.NumEpochs.value                                        = '30';
neunetnue.NumEpochs.text                                        = 'NumEpochs number of training epochs';

neunetnue.Bias.value                                             = '0';
neunetnue.Bias.text                                             = 'allows to take into account the bias if it is set as 1. If bias nodes are not required, bias has to be set as 0';

neunetnue.candidateEpochs.value                                           = '4000';
neunetnue.candidateEpochs.text                                           = 'candidateEpochs is number of maximum iterations needed to train the network with the current candidate. It is used in the outer while of the non-uniform wrapper';

neunetnue.Threshold.value                                        = '0.008';
neunetnue.Threshold.text                                        = 'to be filled in';

neunetnue.DividingPoint.value                                    = '2/3';
neunetnue.DividingPoint.text                                    = 'DividingPoint amount of points used to train the networks. It is expressed as percentage of the data set number of points';

neunetnue.ValStep.value                                          = '15';
neunetnue.ValStep.text                                         = 'ValStep number of iterations after which the validation phase takes place';

neunetnue.ValThreshold.value                                      = '0.6';
neunetnue.ValThreshold.text                                    = 'ValThreshold is the threshold needed during the validation phase';

neunetnue.LearnAlg.value                                         = '@resilientBackPropagation';
neunetnue.LearnAlg.text                                         = 'LearnAlg points to the function used as learning algorithm';

neunetnue.RbpIncrease.value                                      = '1.1';
neunetnue.RbpIncrease.text                                      = 'Please keep the default unless you now what you are doing. For more information visit the website or/and contact the authors';

neunetnue.RbpDescrease.value                                     = '0.9';
neunetnue.RbpDescrease.text                                     = 'Please keep the default unless you now what you are doing. For more information visit the website or/and contact the authors';

neunetnue.RangeW.value                                           = '1';
neunetnue.RangeW.text                                           = 'RangeW it represents the range of values assumed by the weights when initialized. If rangeW is set as 1, the weights will be initialized between -1 and 1';

neunetnue.CoeffHidNodes.value                                    = '0.3';
neunetnue.CoeffHidNodes.text                                    = 'CoeffHidNodes percentage of hidden nodes with respect to the amount of available candidates';

neunetnue.GenCondTermFun.value                                   = '@generateConditionalTerm';
neunetnue.GenCondTermFun.text                                  = 'genCondTermFun is a pointer to function assuming either @generateCondTermLagZero or @generateConditionalTerm values. The first function, generateCondTermLagZero, takes into account the instantaneous effect for the drivers and for the variables indicated in idOtherLagZero. The second function, generateConditionalTerm, will not take into account the instantaneous effect, even if are explicitly mentioned in idOtherLagZero. This parameters should be set in accordance with usePresent.';

neunetnue.UsePresent.value                                       = '0';
neunetnue.UsePresent.text                                       = 'usePresent is an integer assuming 1 or 0 values according to whether genCondTermFun is set to @generateCondTermLagZero or @generateConditionalTerm respectively.';

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