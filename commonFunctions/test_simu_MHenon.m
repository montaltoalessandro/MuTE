%% test PI knn on multiple time series
clear;close all;clc;

%% TE parameters
ii=2; % index of input series
jj=3; % index of output series
k=10; % n. of neighbors
metric='maximum';
Lmax=5; %number of lags for nonuniform embedding scheme
p=2; % order imposed for uniform embedding

numshift=100; minshift=0;alphashift=0.05; %parametri per surro-based termination criterion

%% Simulation - Multiple Henon [Kugiumtzis 2013]
M=5;
C=0; %coupling strength
N=512; %series length
% Ntrans=10000; %transient

% Yo=simu_MHenon(C,M,N,Ntrans);
Yo = coupledhenonmaps2(M,C,N);



%% Non Uniform Embedding
%%% Normalization
for m=1:M 
    Y(:,m)=(Yo(:,m)-mean(Yo(:,m)))/std(Yo(:,m)); 
end
% Y=Yo;

% set candidates
pV=Lmax*ones(1,M);
tau=ones(1,M); u=ones(1,M); zerolag=zeros(1,M);
candidates=SetLag(pV,tau,u,zerolag);

%%% CE approach for embedding
% disp('Non uniform embedding -  CE approach')
% [ceOK,VL1,V1,Eyj]=CEnu_knn(Y,jj,candidates,k,metric);

%%% MI approach for embedding
disp(' ')
disp('Non uniform embedding -  MI approach')
[miOK,CMI,soglia,VL2,V]=MInu_knn(Y,jj,candidates,k,metric,numshift,minshift,alphashift);


%% PI estimation and decomposition

% PI from NU embedding based on CE
% [Py1,Sy1,Tzy1,Txy_z1,out1]=PIknn(Y,VL1,ii,jj,k,metric);

% PI from NU embedding based on MI
% [Py2,Sy2,Tzy2,Txy_z2,out2]=PIknn(Y,VL2,ii,jj,k,metric);

% PI from Uniform embedding
% VLu=SetLag(p*ones(1,M),tau,u,zerolag);
% [Pyu,Syu,Tzy2u,Txy_zu,outu]=PIknn(Y,VLu,ii,jj,k,metric);

% TE from NU embedding based on MI
TE=TEknn(Y,VL2,ii,jj,k,metric);

% clc;
% disp('Embedding vectors [nueCE NaN nueMI]')
% disp([VL1' [NaN; NaN] VL2'])
% disp('Transfer entropies: [ue-nueCE-nueMI_PI,nueMI_TE]')
% disp([Txy_zu Txy_z1 Txy_z2 TE]);

