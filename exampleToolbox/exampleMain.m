%% Experiment using data from ...
% 
% Some explanations about how to set up the methods
% 
%     Method order: please take the order into account because afterwards
%     you should set autoPairwiseTarDriv or handPairwiseTarDriv that need
%     the precise order of the methods
% 
%     binue                                 
%     binnue                                                       
%     linue                              
%     linnue                                                  
%     nnue
%     nnnue
%     neunetue
%     neunetnue
% 
%     Parameters to specify for each method
% 
%%    binue
% 
%     idTargets             = [1 2];
%     idDrivers             = [2;1]';
%     idOtherLagZero        = [3,5];
%     modelOrder            = [5];
%     multi_bivAnalysis     = 'multiv';
%     numQuantLevels        = 6;
%     entropyFun            = @conditionalEntropy;
%     preProcessingFun      = @quantization;
%     firstTermCaseVect     = firstCaseVect;%[1 0];
%     secondTermCaseVect    = secondCaseVect;%[1 1];
%     numSurrogates         = 100;
%     alphaPercentile       = 0.05;
%     tauMin                = 20;
%     ******** Set the following fields together *******
%     genCondTermFun        = @generateConditionalTerm;%@generateCondTermLagZero
%     usePresent            = 0;
%     **************************************************
% 
%%    binnue
% 
%     idTargets             = [ones(1,numSeries)*2 ones(1,numSeries)*6 ones(1,numSeries)*17];
%     idDrivers             = [[1 3:76] [1:63 65:76] [1:73 75 76]];
%     idOtherLagZero        = [3,5,8];
%     modelOrder            = 8;
%     multi_bivAnalysis     = 'multiv';
%     numQuantLevels        = 6;
%     entropyFun            = @evaluateNonUniformEntropy;
%     preProcessingFun      = @quantization;
%     secondTermCaseVect    = caseVect;%[1 1];
%     numSurrogates         = 100;
%     alphaPercentile       = 0.05;
%     ******** Set the following fields together *******
%     genCondTermFun        = @generateConditionalTerm;%@generateConditionalTerm_selectionVar;%@generateCondTermLagZero
%     usePresent            = 0;
%     scalpConduction       = 0;
% % **************************************************
%%    linue
% 
%     idTargets             = [ones(1,18) ones(1,18)*2 ones(1,18)*3 ones(1,18)*4 ones(1,18)*5 ones(1,18)*6 ones(1,18)*7 ones(1,18)*8 ones(1,18)*9 ones(1,18)*10 ones(1,18)*11 ones(1,18)*12 ones(1,18)*13 ones(1,18)*14 ones(1,18)*15 ones(1,18)*16 ones(1,18)*17 ones(1,18)*18 ones(1,18)*19];%[ones(1,3) ones(1,3)*2 ones(1,3)*3 ones(1,3)*4]
%     idDrivers             = [[2:19] [1 3:19] [1:2 4:19] [1:3 5:19] [1:4 6:19] [1:5 7:19] [1:6 8:19] [1:7 9:19] [1:8 10:19] [1:9 11:19] [1:10 12:19] [1:11 13:19] [1:12 14:19] [1:13 15:19] [1:14 16:19] [1:15 17:19] [1:16 18:19] [1:17 19] [1:18]];%[2 3 4 1 3 4 1 2 4 1 2 3]
%     idOtherLagZero        = [3,5,8,...];
%     modelOrder            = [5;5;5;5;5];
%     multi_bivAnalysis     = 'multiv';
%     minOrder              = 5;
%     maxOrder              = 5;
%     orderCriterion        = 'bayesian';
%     entropyFun            = @linearEntropy;
%     firstTermCaseVect     = caseVect1;%[1 0];
%     secondTermCaseVect    = caseVect2;%[1 1];
%     % ******** Set the following fields together *******
%     genCondTermFun        = @generateConditionalTerm;%@generateCondTermLagZero
%     usePresent            = 0;
%     % **************************************************
% 
%%    linnue
% 
%     idTargets             = [1 2];
%     idDrivers             = [2;1]';
%     idOtherLagZero        = [3,5];
%     modelOrder            = [10;10;10;10;10];
%     multi_bivAnalysis     = 'biv';
%     entropyFun            = @evaluateLinearNonUniformEntropy;
%     secondTermCaseVect    = caseVect;[1 1]
%     numSurrogates         = 100;
%     alphaPercentile       = 0.01;
%     % ******** Set the following fields together *******
%     genCondTermFun        = @generateConditionalTerm;%@generateCondTermLagZero
%     usePresent            = 0;
%     % **************************************************
% 
%%    nnue
% 
%     idTargets             = [1 2];
%     idDrivers             = [2;1]';
%     idOtherLagZero        = [3,5];
%     modelOrder            = 5;
%     multi_bivAnalysis     = 'biv';
%     firstTermCaseVect     = caseVect;
%     numSurrogates         = 100;
%     metric                = 'maximum';
%     numNearNei            = 10;
%     funcDir               = '/home/alessandro/Dropbox/Phd/toolbox_weHope/OpenTSTOOL/tstoolbox/mex/mexa64/';
%     homeDir               = '/home/alessandro/Dropbox/Phd/toolbox_weHope/';
%     alphaPercentile       = 0.05;
%     tauMin                = 20;
%     % ******** Set the following fields together *******
%     genCondTermFun        = @generateConditionalTerm;%@generateCondTermLagZero
%     usePresent            = 0;
%     % **************************************************
%
%%    nnnue
% 
%     idTargets                       = [3 3 3 4 4 4];
%     idDrivers                       = [2;1;4;3;5;2]';
%     idOtherLagZero                  = [1,5,8,...];
%     modelOrder                      = 5;
%     multi_bivAnalysis               = 'multiv';
%     secondTermCaseVect              = caseVect;%[1 1];
%     numSurrogates                   = 100;
%     metric                          = 'maximum';
%     numNearNei                      = 10;
%     informationTransCriterionFun    = @nearNeiConditionalMutualInformation;
%     surrogatesTestFun               = @evalNearNeiTestSurrogates2rand;
%     funcDir                         = '/home/alessandro/Dropbox/Phd/toolbox_weHope/OpenTSTOOL/tstoolbox/mex/mexa64/';
%     homeDir                         = '/home/alessandro/Dropbox/Phd/toolbox_weHope/';
%     alphaPercentile                 = 0.05;
%     % ******** Set the following fields together *******
%     genCondTermFun                  = @generateConditionalTerm;%@generateCondTermLagZero
%     usePresent                      = 0;
%     % **************************************************
% 
%%    neunetue
% 
%     idTargets              = [1 2 3 4];
%     idDrivers              = [5 6 1 2];
%     idOtherLagZero         = [3,5,8,1];
%     modelOrder             = 8;
%     secondTermCaseVect     = [1 1];
%     multi_bivAnalysis      = 'multiv';
%     eta                    = 0.01;
%     alpha                  = 0.01;
%     fracTrainSet           = 3/4;
%     actFunc                = {@sigmoid @identity};
%     numEpochs              = 30;
%     bias                   = 0;
%     epochs                 = 4000;
%     threshold              = 20/100;
%     dividingPoint          = 3/4;
%     valStep                = 5;
%     valThreshold           = 0.1/100;
%     learnAlg               = @resilientBackPropagation;
%     rbpIncrease            = 1.1;
%     rbpDecrease            = 0.9;
%     rangeW                 = 1;
%     coeffHidNodes          = 0.3;
%     % ******** Set the following fields together *******
%     paramsNonUniNeuralNet.genCondTermFun         = @generateConditionalTerm;%@generateCondTermLagZero
%     paramsNonUniNeuralNet.usePresent             = 0;
%     % **************************************************
%
%%    neunetnue
% 
%     nnData                 = ...;
%     idTargets              = [1 2 3 4];
%     idDrivers              = [5 6 1 2];
%     idOtherLagZero         = [3,5,8,1];
%     modelOrder             = 8;
%     firstTermCaseVect      = [1 0];
%     secondTermCaseVect     = [1 1];
%     multi_bivAnalysis      = 'multiv';
%     eta                    = 0.01;
%     alpha                  = 0.01;
%     fracTrainSet           = 3/4;
%     actFunc                = {@sigmoid @identity};
%     numEpochs              = 30;
%     bias                   = 0;
%     epochs                 = 4000;
%     threshold              = 20/100;
%     dividingPoint          = 3/4;
%     valStep                = 5;
%     valThreshold           = 0.1/100;
%     learnAlg               = @resilientBackPropagation;
%     rbpIncrease            = 1.1;
%     rbpDecrease            = 0.9;
%     rangeW                 = 1;
%     coeffHidNodes          = 0.3;
%     % ******** Set the following fields together *******
%     paramsNonUniNeuralNet.genCondTermFun         = @generateConditionalTerm;%@generateCondTermLagZero
%     paramsNonUniNeuralNet.usePresent             = 0;
%     % **************************************************





    %% ***************************************************
    %% PAY ATTENTION: to run this example you should just set the path at lines 146, 153 and 196 according to your operating system and folder in which MuTE is stored
    %% PAY ATTENTION: maybe MATLAB can report errors because you are not able to run the parallel session, so by default the parfor in parametersAndMethods, line 250
    %%                and in callingMethods, line 18, are set as for
    %% ***************************************************


    %% Set MuTE folder path including also all the subfolders, for instance
    mutePath = ('/Users/alessandromontalto/Dropbox/MuTE_onlineVersion/'); % Adjust according to your path -> just an example: mutePath = '/home/alessandro/Scrivania/MuTE/';
%     cd(mutePath);
%     addpath(genpath(pwd));
    
    nameDataDir  = 'exampleToolbox/';
    
    %% Set the directory in which the data files are stored. In this directory the outcome of the experiments will be stored too.
    dataDir      = ['/Users/alessandromontalto/Dropbox/MuTE_onlineVersion/' nameDataDir]; % Adjust according to your path -> just as example: dataDir = ['/home/alessandro/Scrivania/MuTE/' nameMainDir];
    
    % *****************************************************
    %% PAY ATTENTION: if you are able to run the parallel session you can set numProcessors > 1
    numProcessors               = 1;
    % *****************************************************


        
    %% EXPERIMENTS
    

    cd(dataDir);

%%  Defining the strings to load the data files
    dataFileName    = 'realization_5000p_1';
    dataLabel       = '';
    dataExtension   = '.mat';
    

%%     making storing folders
    
    resDir          = [dataDir dataFileName '_' dataLabel '/'];
    if (~exist([dataDir 'resDir'],'dir'))
        mkdir(resDir);
    end
    copyDir   = [resDir 'entropyMatrices' dataLabel '/'];
    if (~exist([resDir 'copyDir'],'dir'))
        mkdir(copyDir);
    end
    

%%    defining result directories 

    cd(dataDir);
    resultDir           = [resDir 'results' dataLabel '/'];
    if (~exist([resDir 'resultDir'],'dir'))
        mkdir(resultDir);
    end
    
    % *****************************************************
    %% Indicate the path of the mexa64 file to run the nearest neighbour method. 
    %% PAY ATTENTION: maybe this file should be compiled on your own machine. This file is important to run nnue and nnnue methods.
    %% By default these methods are commented to avoid any error
    nnMexa64Path = '/Users/alessandromontalto/Dropbox/MuTE_onlineVersion/OpenTSTOOL/tstoolbox/mex/mexa64/'; % Adjust according to your path -> just an example nnMexa64Path = '/home/alessandro/Scrivania/MuTE/OpenTSTOOL/tstoolbox/mex/mexa64/';
    % *****************************************************

%%  Defining the experiment parameters
    channels             = 1:3;
    samplingRate         = 1;
    pointsToDiscard      = 0;
    listRealization      = dir([dataDir [dataFileName '*' dataLabel '*' dataExtension]]);
    autoPairwiseTarDriv  = [1 1 1 1 1 1 1 1];
    handPairwiseTarDriv  = [0 0 0 0 0 0 0 0];
    
%   neunetnue parameters
    threshold           = 0.008;
    valThreshold        = 0.6;
    numHiddenNodes      = 0.3;
    
%  
       %% STATISTICAL METHODS

    fprintf('\n******************************\n\n');
    disp('Computing statistical methods...');
    fprintf('\n\n');

    tic
    [output1,params1]               = parametersAndMethods(listRealization,samplingRate,pointsToDiscard,channels,autoPairwiseTarDriv,...
                                      handPairwiseTarDriv,resultDir,dataDir,copyDir,numProcessors,...
                                      'linue',[],[],[],5,'multiv',5,5,'bayesian',@linearEntropy,[1 0],[1 1],@generateConditionalTerm,0,...
                                      'linnue',[],[],[],5,'multiv',@evaluateLinearNonUniformEntropy,[1 1],100,0.05,@generateConditionalTerm,0,...
                                      'binue',[],[],[],5,'multiv',6,@conditionalEntropy,@quantization,[1 0],[1 1],100,0.05,20,...
                                      @generateConditionalTerm,0,...
                                      'binnue',[],[],[],5,'multiv',6,@evaluateNonUniformEntropy,@quantization,[1 1],100,0.05,@generateConditionalTerm,0,0,...
                                      'neunetue',[],[],[],5,[1 1],'multiv',[],[],{@sigmoid @identity},30,0,4000,2/3,15,...
                                      valThreshold,@resilientBackPropagation,1.1,0.9,1,numHiddenNodes,100,20,0.05,@generateConditionalTerm,0,...
                                      'neunetnue',[],[],[],[],5,[1 0],[1 1],'multiv',[],[],{@sigmoid @identity},30,0,4000,threshold,2/3,15,...
                                      valThreshold,@resilientBackPropagation,1.1,0.9,1,numHiddenNodes,@generateConditionalTerm,1,...
                                      'nnue',[],[],[],5,'multiv',[1 1],100,'maximum',10,nnMexa64Path,mutePath,0.05,10,@generateConditionalTerm,0,...
                                      'nnnue',[],[],[],5,'multiv',[1 1],100,'maximum',10,@nearNeiConditionalMutualInformation,...
                                      @evalNearNeiTestSurrogates2rand,nnMexa64Path,mutePath,0.05,@generateConditionalTerm,0);
    close all
    toc


    fprintf('\n\n');
    disp('...computation done!');
    fprintf('\n\n');
    
    close all
    cd(mutePath);
    exit;


    
    
    