%% k-nearest neighbor Estimation of the Partial Transfer Entropy
% Computes the transfer entropy from the column ii to column jj of Y, conditioned to the remaining columns

function [TE]=PTEknn(Y,V,ii,jj,k,metric,funcDir,homeDir)

%reordering V
[V(:,1) orderedId] = sort(V(:,1));
cpSecondDimV = V(:,2);
V(:,2) = cpSecondDimV([orderedId]);

ii = sort(ii,'descend');

if isempty(V)
    TE=0;
    return
end

[Ny,M]=size(Y);

B=buildvectors(Y,jj,V); %% form the observation matrix
N=size(B,1);

% set subspaces of lower dimension
A=B; A(:,1)=[];
XYZ=A;
tmp=V(:,1); %iYZ=find(tmp~=ii);
% tmp = sort(tmp);
iYZ = [1:size(tmp)]';
for i = 1:size(ii)
    iYZ(tmp==ii(i)) = [];
end
YZ=A(:,iYZ);
yYZ=[B(:,1) YZ];

cd(funcDir);
% neighbor search in space of higher dimension
atria = nn_prepare(B, metric);
[~, distances] = nn_search(B, atria, (1:N)', k, 0);
dd=distances(:,k);


% range searches in subspaces of lower dimension
atriaXYZ = nn_prepare(XYZ, metric);
[countXYZ, neighbors] = range_search(XYZ, atriaXYZ, (1:N)', dd, 0);
tmp=neighbors(:,2);%subtraction from count of points with distance exactly equal to k-th neighbor
for n=1:length(tmp)
%     countXYZ(n)=countXYZ(n)-sum(tmp{n}==dd(n));
    countXYZ(n)=max(k-1,countXYZ(n)-sum(tmp{n}==dd(n)));
end

atriayYZ = nn_prepare(yYZ, metric);
[countyYZ, neighbors] = range_search(yYZ, atriayYZ, (1:N)', dd, 0);
tmp=neighbors(:,2); %subtraction from count of points with distance exactly equal to k-th neighbor
for n=1:length(tmp)
%     countyYZ(n)=countyYZ(n)-sum(tmp{n}==dd(n));
    countyYZ(n)=max(k-1,countyYZ(n)-sum(tmp{n}==dd(n)));
end


if ~isempty(YZ)
    atriaYZ = nn_prepare(YZ, metric);
    [countYZ, neighbors] = range_search(YZ, atriaYZ, (1:N)', dd, 0);
    tmp=neighbors(:,2); %subtraction from count of points with distance exactly equal to k-th neighbor
    for n=1:length(tmp)
%         countYZ(n)=countYZ(n)-sum(tmp{n}==dd(n));
        countYZ(n)=max(k-1,countYZ(n)-sum(tmp{n}==dd(n)));
    end
else
    countYZ=(N-1)*ones(N,1);
end

cd(homeDir);
% equation of wibral for transfer entropy
TE = psi(k) + (1/N) * ( sum(psi(countYZ+1)) - sum(psi(countyYZ+1)) - sum(psi(countXYZ+1)) ); 




 

    
