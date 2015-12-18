%% NONUNIFORM MIXED EMBEDDING for PREDICTIVE INFORMATION based on nearest neighbors
%% Approach 2): Mutual Information estimation
% stops at minimum CMI (like in Kugiumtzis2013)

%%% INPUTS:
% data: N*M matrix of the M signals each having length N
% j: index (column) of the series considered as output, the one we want to describe
% candidates: two column vector of candidate series (col 1) and lag (col 2) indexes
% k: number of the nearest neighbor to search for distance
% metric: 'maximum' or 'euclidian'

% note: minshift>0 (typically 20) entails significance test using shift surrogates
% set minshift=0 to do random shuffling instead of time shift!

function [miOK,CMI,soglia,VL,V]=MInu_knn(data,j,candidates,nnk,metric,numshift,minshift,alphashift)

%% prepare for iteration
candidates=[candidates NaN*ones(size(candidates,1),1)]; %NaN in 3rd column

%Shannon Entropy of yj(n) based on knn
% Eyj=SEknn(data(:,j),nnk,metric);


%% compute Conditional entropy - iterate
exitcrit=0; %exit criterion: stay in loop if exitcrit==0
V=[];
miOK(1)=0; % initialize MI between target series and embedding vector
k=2;

while exitcrit==0
    disp(['NUembed, step ' int2str(k-1) '...']);
    mi=NaN*ones(size(candidates,1),1);
    %d=NaN*ones(size(candidates,1),1);
    
    % Test the candidates
    for i=1:size(candidates,1)
        if isnan(candidates(i,3)) % test i-th candidate, only if not already included in V
            Vtmp=[V; candidates(i,1:2)];
            B=buildvectors(data,j,Vtmp);
            mi(i)=MIknn(B,nnk,metric); % mutual information knn
        end
    end    
    
    %% select the candidate and update the embedding vector    
    ind_sel=find(mi==max(mi)); 
    if ~isempty(ind_sel)
        ind_sel=ind_sel(1); % index of the selected candidate
        candidates(ind_sel,3)=1; %mark as selected
        V=[V; candidates(ind_sel,1:2)]; %update embedding vector
        miOK(k)=max(mi); %update the maximum mi at step k
    else    % ho testato tutti i candidati ed è sempre salito!
        miOK(k)=miOK(k-1); %la fisso pianeggiante, per poter uscire
        V=[V; V(k-2,1:2)]; %fake update embedding vector (copio il precedente)
    end
    
    %% test for significance of the new selected candidate (exit criterion)
    B=buildvectors(data,j,V); %riprendo la observation matrix che ha dato la mi massima
    CMI(k-1)=CMIknn(B,nnk,metric); % conditional mutual information of the selected term (nn estimate)

    maxshift=size(B,1)-minshift;
    CMIs=NaN*ones(numshift,1);
    for is=1:numshift
        if minshift==0 % alternative to timeshift: RANDOM SHUFFLING (minshift=0 used as flag)
            xs=B(:,size(B,2));
            xs=xs(randperm(length(xs)));
            x1s=B(:,1); x1s=x1s(randperm(length(x1s))); % Dimitris suggestion: randomize also target variable 
        else
            lagshift=fix(rand*(maxshift-minshift+1)+minshift);% shift casuale tra minshift e maxshift 
            xs=circshift(B(:,size(B,2)),lagshift);%is-esimo shift dei valori del candidato scelto
            lagshift1=fix(rand*(maxshift-minshift+1)+minshift);
            x1s=circshift(B(:,1),lagshift1); % Dimitris suggestion: randomize also target variable
        end             
        Bs=B; Bs(:,end)=xs; % sostituisco l'ultima colonna di B col termine shiftato
        Bs(:,1)=x1s; % Dimitris suggestion: randomize also target variable
        CMIs(is)=CMIknn(Bs,nnk,metric);
    end
    soglia(k-1)=prctile(CMIs,100*(1-alphashift));

    if CMI(k-1)<=soglia(k-1) % the term is not significant
        exitcrit=1;
    else % the term is significant: update k and stay in
        k=k+1;
    end
        
    
end %while

%%% After exiting: final values
miOK=miOK';
L=k-2; %optimal embedding length
VL=V(1:L,:); %optimal embedding



