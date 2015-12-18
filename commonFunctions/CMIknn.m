%% k-nearest neighbor Estimation of Conditional Mutual Information
% Computes the CMI between the first and the last column of B, conditioned to the remaining columns

function [CMI]=CMIknn(B,k,metric)

% epsi=0.000001; %tolerance when cheating range_search (otherwise counts points at distance not strictly less)
epsi=0; %do not apply any cheat

[N,M]=size(B);

% neighbor search in space of higher dimension
atria = nn_prepare(B, metric);
[~, distances] = nn_search(B, atria, (1:N)', k, 0);
dd=distances(:,k);
dd=dd.*(1-epsi);

% set subspaces of lower dimension
A=B(:,1:end-1); % y and V
B2=B(:,2:end); % V and w
A2=A(:,2:end); % V alone

% range searches in subspaces of lower dimension
atriaA = nn_prepare(A, metric);
[countA, neighbors] = range_search(A, atriaA, (1:N)', dd, 0);
%subtraction from count of points with distance exactly equal to k-th neighbor
tmp=neighbors(:,2);
for n=1:length(tmp)
    countA(n)=countA(n)-sum(tmp{n}==dd(n));
end

atriaB2 = nn_prepare(B2, metric);
[countB2, neighbors] = range_search(B2, atriaB2, (1:N)', dd, 0);
%subtraction from count of points with distance exactly equal to k-th neighbor
tmp=neighbors(:,2);
for n=1:length(tmp)
    countB2(n)=countB2(n)-sum(tmp{n}==dd(n));
end


if isempty(A2) %no subspace = no conditioning
    % equation for mutual information
    CMI = psi(k) + psi(N) + (1/N) * (- sum(psi(countA+1)) - sum(psi(countB2+1)) ); 
else
    atriaA2 = nn_prepare(A2, metric);
    [countA2, neighbors] = range_search(A2, atriaA2, (1:N)', dd, 0);
    %subtraction from count of points with distance exactly equal to k-th neighbor
    tmp=neighbors(:,2);
    for n=1:length(tmp)
        countA2(n)=countA2(n)-sum(tmp{n}==dd(n));
    end
 
    % equation for conditional mutual information
    CMI = psi(k) + (1/N) * ( sum(psi(countA2+1)) - sum(psi(countA+1)) - sum(psi(countB2+1)) ); 
end
    
