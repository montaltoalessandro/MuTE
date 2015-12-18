close all;
%% Computing Synthetic Data Set 
sigma=0.05;
[X,Y] = meshgrid(-1:.2:1, -1:.2:1);
rows=size(X,1);
cols=size(X,2);
Z = 4*X .* exp(-2*X.^2 - 2*Y.^2);
noised_Z= Z +sigma*randn(rows,cols);

figure;
surf(X,Y,noised_Z);
hold on;
title('dataset');

count=0;
for j=1:cols
    for i=1:rows
        count=count+1;
        XT(count,:)=[ X(i,j) Y(i,j)];
        YT(count,:)=noised_Z(i,j);
    end
end

[N d]=size(XT);
%Building the network
ffwNet=createFfw([2 5 1],{@sigmoid @identity},1);
%Building the learning parameters
learnParams=createLearnParams(XT,YT,{@derivSigmoid @derivIdentity});

% %EXAMPLE 1: gradientDescent
% %Online case: Uncomment the following line 
% learnParams=setLearnParams(learnParams,'batch',0);
% %
% %Setting the learning algorithm 
% learnParams=setLearnParams(learnParams,'learningAlgorithm',@gradientDescent);
% %Setting learning algorithm parameters
% learnParams=setLearnParams(learnParams,'eta',0.005);


% %EXAMPLE 2: gradientDescentWithMoment
% %Setting the learning algorithm 
% learnParams=setLearnParams(learnParams,'learningAlgorithm',@gradientDescentWithMoment);
% %Setting learning algorithm parameters
% learnParams=setLearnParams(learnParams,'eta',0.005);
% learnParams=setLearnParams(learnParams,'alpha',0.5);

%EXAMPLE 3: resilientBackPropagation
%Setting the learning algorithm 
learnParams=setLearnParams(learnParams,'learningAlgorithm',@resilientBackPropagation);
%Setting learning algorithm parameters: Uncomment the following two lines 
% and change the parameter values
% rbpParam=createRBPParam(1.1,0.9,1E-03,1E-20,50);
% learnParams=setLearnParams(learnParams,'RBPParam',rbpParam);

%Setting further learning parameters
learnParams=setLearnParams(learnParams,'maxEpochs',1000);

%Uncomment to choose the weight layers to be updated
% learnParams=setLearnParams(learnParams,'wLayersToBeUpdated',[1 2]);

%LEARNING
%Debugging mode
[ffwNet learnParams SQE_T RMSE_T SQE_V RMSE_V]=ffwLearning(ffwNet,learnParams,1);
%No debugging mode
%[ffwNet learnParams SQE_T RMSE_T SQE_V RMSE_V]=ffwLearning(ffwNet,learnParams);

%Plot error
figure;
title('SQ error over training points');
hold on;
plot(SQE_T,'r*');
figure;
title('RMS error over training points');
hold on;
plot(RMSE_T,'bo');


% TEST
net_Y=ffwSim(ffwNet,XT);
figure;
surf(X,Y,reshape(net_Y,rows,cols));
hold on;
title('network response');
