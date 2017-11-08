% This script may be used to reproduce the results on cardiovascular data as presented in the PLOSone paper Figure 10
% This was only tested for the bin uniform and non-uniform estmators.
mutePath = '/home/rob/Downloads/MuTE_guiUpdate/';
nnMexa64Path = [mutePath 'OpenTSTOOL/tstoolbox/mex/mexa64/'];

modOrder = 5;
NumQuant = 6;

%signal description
% 1     RR
% 2     SAP
% 3     Res

idTargets =       [1 1 2 2 3 3];
idDrivers =       [2 3 1 3 1 2;...
                   2 3 0 3 0 0];
idOthersLagZero = [3 2 3 0 0 0];

%genTermFun = @generateConditionalTerm;
genTermFun = @generateCondTermLagZero;
usePresent = 1;

dataDir = [mutePath 'cardiovascular_data/'];
dataFileName = 's-';
dataLabel = '';
dataExtension = '.mat';
resDir = [dataDir dataFileName '*' dataLabel filesep];
if (~exist([dataDir 'resDir'],'dir'))
  mkdir(resDir);
  end
copyDir   = [resDir 'entropyMatrices_' dataLabel '/'];
if (~exist([resDir 'copyDir'],'dir'))
  mkdir(copyDir);
 end

%defining results directories
 cd(dataDir)
resultDir           = [resDir 'results_' dataLabel '/'];
if (~exist([resDir 'resultDir'],'dir'))
 mkdir(resultDir);
end

%get the realization
listRealization = dir([dataDir 's-*.mat']); 


 %%here the analysis is done with all parameters defined in the gui. WARNING: the computation is taking place in another workspace. Please wait until (...COMPUTATION DONE!) is displayed. 
 [output1,params1] = parametersAndMethods(listRealization,1,0,1:3,[0 0 0 0 0 0 0 0],[0 0 0 0 0 0 0 0],resultDir,dataDir,copyDir,4,...
    'binue',idTargets,idDrivers,idOthersLagZero,modOrder,'multiv',NumQuant,@conditionalEntropy,@quantization,[1 0],[1 1],100,0.05,20,genTermFun,usePresent,...
    'binnue',idTargets,idDrivers,idOthersLagZero,modOrder,'multiv',NumQuant,@evaluateNonUniformEntropy,@quantization,[1 1],100,0.05,genTermFun,usePresent,0);


dataFileName = 't-';
dataLabel = '';
dataExtension = '.mat';
resDir = [dataDir dataFileName '*' dataLabel filesep];
if (~exist([dataDir 'resDir'],'dir'))
  mkdir(resDir);
  end
copyDir   = [resDir 'entropyMatrices_' dataLabel '/'];
if (~exist([resDir 'copyDir'],'dir'))
  mkdir(copyDir);
 end

% defining results directories
 cd(dataDir)
resultDir           = [resDir 'results_' dataLabel '/'];
if (~exist([resDir 'resultDir'],'dir'))
 mkdir(resultDir);
end

% get the realization
listRealization = dir([dataDir 't-*.mat']); 

%here the analysis is done with all parameters defined in the gui. WARNING: the computation is taking place in another workspace. Please wait until (...COMPUTATION DONE!) is displayed. 
 [output1,params1] = parametersAndMethods(listRealization,1,0,1:3,[0 0 0 0 0 0 0 0],[0 0 0 0 0 0 0 0],resultDir,dataDir,copyDir,4,...
    'binue',idTargets,idDrivers,idOthersLagZero,modOrder,'multiv',NumQuant,@conditionalEntropy,@quantization,[1 0],[1 1],100,0.05,20,genTermFun,usePresent,...
    'binnue',idTargets,idDrivers,idOthersLagZero,modOrder,'multiv',NumQuant,@evaluateNonUniformEntropy,@quantization,[1 1],100,0.05,genTermFun,usePresent,0);

fprintf('\n\n'); disp('...COMPUTATION DONE!'); fprintf('\n\n');%close all
cd(dataDir)

% 1 - RR
% 2 - SAP
% 3 - Res
% [1 1 2 2 3 3]
% [2 3 1 3 1 2]

% 1         2           3           4               5           6
% SAP->RR   Res->RR     RR->SAP     Res->SAP        RR->Res     SAP->Res

%% Bin NUE
load([dataDir 't-*/entropyMatrices_/binnue_transferEntropyMtx.mat'])
upright = matrixTransferEntropy(1:15,:);
load([dataDir 's-*/entropyMatrices_/binnue_transferEntropyMtx.mat'])
supine = matrixTransferEntropy(1:15,:);

[mean(supine); mean(upright)]

figure('Color',[1 1 1]);
h1=plot([1 2 3],[mean(supine(:,2)) mean(supine(:,3)) mean(supine(:,5))],'.r','MarkerSize',20,'LineWidth',2);hold on
h2=plot([1 1], mean(supine(:,2))+[-1 1]*se(supine(:,2)),'-r',...
    [2 2], mean(supine(:,3))+[-1 1]*se(supine(:,3)),'-r',...
    [3 3], mean(supine(:,5))+[-1 1]*se(supine(:,5)),'-r','MarkerSize',20,'LineWidth',2);
h3=plot([1 2 3],[mean(upright(:,2)) mean(upright(:,3)) mean(upright(:,5))],'.b','MarkerSize',20,'LineWidth',2);
h4=plot([1 1], mean(upright(:,2))+[-1 1]*se(upright(:,2)),'-b',...
    [2 2], mean(upright(:,3))+[-1 1]*se(upright(:,3)),'-b',...
    [3 3], mean(upright(:,5))+[-1 1]*se(upright(:,5)),'-b','MarkerSize',20,'LineWidth',2);
hold off
xlim([0,4]);ylim([0,1])
grid on
set(gca,'XTick',[1 2 3])
ylabel('TE in arb. un.')
set(gca,'XTickLabel',{'SAP->RR','Res->RR','Res->SAP'})
title('Bin NUE')
legend([h1,h3],{'supine','upright'},'Location','northwest')

set(gcf, 'PaperPosition', [0 0 20 20]);
set(gcf, 'PaperSize', [20 20]);
saveas(gcf, 'Bin_NUE.pdf', 'pdf')

%% Bin UE
load([dataDir 't-*/entropyMatrices_/binue_transferEntropyMtx.mat'])
upright = matrixTransferEntropy(1:15,:);
load([dataDir 's-*/entropyMatrices_/binue_transferEntropyMtx.mat'])
supine = matrixTransferEntropy(1:15,:);
[mean(supine)' mean(upright)']

figure('Color',[1 1 1]);
h1=plot([1 2 3],[mean(supine(:,2)) mean(supine(:,3)) mean(supine(:,5))],'.r','MarkerSize',20,'LineWidth',2);hold on
h2=plot([1 1], mean(supine(:,2))+[-1 1]*se(supine(:,2)),'-r',...
    [2 2], mean(supine(:,3))+[-1 1]*se(supine(:,3)),'-r',...
    [3 3], mean(supine(:,5))+[-1 1]*se(supine(:,5)),'-r','MarkerSize',20,'LineWidth',2);
h3=plot([1 2 3],[mean(upright(:,2)) mean(upright(:,3)) mean(upright(:,5))],'.b','MarkerSize',20,'LineWidth',2);
h4=plot([1 1], mean(upright(:,2))+[-1 1]*se(upright(:,2)),'-b',...
    [2 2], mean(upright(:,3))+[-1 1]*se(upright(:,3)),'-b',...
    [3 3], mean(upright(:,5))+[-1 1]*se(upright(:,5)),'-b','MarkerSize',20,'LineWidth',2);
hold off
xlim([0,4]);ylim([0,.06])
grid on
set(gca,'XTick',[1 2 3])
ylabel('TE in arb. un.')
set(gca,'XTickLabel',{'SAP->RR','Res->RR','Res->SAP'})
title('Bin UE')
legend([h1,h3],{'supine','upright'},'Location','northwest')

set(gcf, 'PaperPosition', [0 0 20 20]);
set(gcf, 'PaperSize', [20 20]);
saveas(gcf, 'Bin_UE.pdf', 'pdf')

