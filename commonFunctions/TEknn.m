%% k-nearest neighbor Estimation of the Transfer Entropy
% Computes the transfer entropy from the column ii to column jj of Y, conditioned to the remaining columns

% Y= data matrix
% V= embedding vector (candidati selezionati)
% ii= indice della driver series
% jj= indice della target series


function [TE]=TEknn(Y,V,ii,jj,k,metric,funcDir,homeDir)

% epsi=0.001; %tolerance when cheating range_search (otherwise counts points at distance not strictly less)
epsi=0; %do not apply any cheat

[Ny,M]=size(Y);

B=buildvectors(Y,jj,V); %% form the observation matrix
N=size(B,1);

cd(funcDir);
% neighbor search in space of higher dimension
atria = nn_prepare(B, metric);
[~, distances] = nn_search(B, atria, (1:N)', k, 0);
dd=distances(:,k);
dd=dd.*(1-epsi);

% set subspaces of lower dimension
A=B; 
A(:,1)=[];
XYZ=A;
% tmp=V(:,1);
tmpIdDriv = V(:,1);
for i = 1 : length(ii)
    a = find(tmpIdDriv == ii(i));
    if ~isempty(a)
       tmpIdDriv(a) = 0; 
    end
end
idCondTerm = find(tmpIdDriv > 0);
YZ = A(:,idCondTerm);
% iYZ=find(tmp~=ii);
% YZ=A(:,iYZ);
% YZ = tmpA;
yYZ=[B(:,1) YZ];

% range searches in subspaces of lower dimension
atriaXYZ = nn_prepare(XYZ, metric);
[countXYZ, neighbors] = range_search(XYZ, atriaXYZ, (1:N)', dd, 0);
%subtraction from count of points with distance exactly equal to k-th neighbor
tmp=neighbors(:,2);
for n=1:length(tmp)
    countXYZ(n)=countXYZ(n)-sum(tmp{n}==dd(n));
end

atriaYZ = nn_prepare(YZ, metric);
[countYZ, neighbors] = range_search(YZ, atriaYZ, (1:N)', dd, 0);
%subtraction from count of points with distance exactly equal to k-th neighbor
tmp=neighbors(:,2);
for n=1:length(tmp)
    countYZ(n)=countYZ(n)-sum(tmp{n}==dd(n));
end

atriayYZ = nn_prepare(yYZ, metric);
[countyYZ, neighbors] = range_search(yYZ, atriayYZ, (1:N)', dd, 0);
%subtraction from count of points with distance exactly equal to k-th neighbor
tmp=neighbors(:,2);
for n=1:length(tmp)
    countyYZ(n)=countyYZ(n)-sum(tmp{n}==dd(n));
end

cd(homeDir);
 
% equation of wibral for transfer entropy
TE = psi(k) + (1/N) * ( sum(psi(countYZ+1)) - sum(psi(countyYZ+1)) - sum(psi(countXYZ+1)) ); 
    
