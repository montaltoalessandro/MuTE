function [MI] = evalNNMutualInfo(B,metric,k,funcDir,homeDir)
%% k-nearest neighbor Estimation of Mutual Information
% Computes the mutual information between the first column and the remaining columns of the input matrix B


    % epsi=0.001; %tolerance when cheating range_search (otherwise counts points at distance not strictly less)
    epsi=0; %do not apply any cheat

    [N,M]=size(B);


    cd(funcDir);
    % neighbor search in space of higher dimension
    atria = nn_prepare(B, metric);
    [~, distances] = nn_search(B, atria, (1:N)', k, 0);
    dd=distances(:,k);
    dd=dd.*(1-epsi);

    % set subspaces of lower dimension
    V=B(:,2:end);
    y=B(:,1);

    % range searches in subspaces of lower dimension
    atriaV = nn_prepare(V, metric);
    [countV, neighbors] = range_search(V, atriaV, (1:N)', dd, 0);
    %subtraction from count of points with distance exactly equal to k-th neighbor
    tmp=neighbors(:,2);
    for n=1:length(tmp)
        countV(n)=countV(n)-sum(tmp{n}==dd(n));
    end

    atriay = nn_prepare(y, metric);
    [county, neighbors] = range_search(y, atriay, (1:N)', dd, 0);
    %subtraction from count of points with distance exactly equal to k-th neighbor
    tmp=neighbors(:,2);
    for n=1:length(tmp)
        county(n)=county(n)-sum(tmp{n}==dd(n));
    end

    % equation for mutual information [Kraskov 2004]
    MI = psi(k) + psi(N) - (1/N)*(sum(psi(countV+1))) - (1/N)*(sum(psi(county+1))) ;

    cd(homeDir);

return;