%% k-nearest neighbor Estimation of the Predictive Information and decomposition
% Computes Py=Sy+Tzy+Txy_z from the columns of Y
% V= assigned embedding vector
% ii= indexes of X; jj=index of Y

function [Py,Sy,Tzy,Txy_z,out]=PIknn(Y,V,ii,jj,k,metric,funcDir,homeDir)

    % epsi=0.001; %tolerance when cheating range_search (otherwise counts points at distance not strictly less)
    epsi=0;

    %% form the observation matrices
    B=buildvectors(Y,jj,V); 
    A=B(:,2:end);
    tmp=V(:,1);

    i_Y= tmp==jj;
    % i_YZ= tmp~=ii;

    M_yXYZ=B;
    M_y=B(:,1);
    M_XYZ=A;
    M_Y=A(:,i_Y);
    tmpIdDriv = V(:,1);
    for i = 1 : length(ii)
        a = find(tmpIdDriv == ii(i));
        if ~isempty(a)
           tmpIdDriv(a) = 0; 
        end
    end
    idCondTerm = find(tmpIdDriv > 0);
    M_YZ = A(:,idCondTerm);
    % M_YZ=A(:,i_YZ);
    M_yY=[M_y M_Y];
    M_yYZ=[M_y M_YZ];

    %[Ny,M]=size(Y);
    N=size(B,1);

    cd(funcDir);
    %% kNN analysis
    % neighbor search in space of higher dimension
    atria_yXYZ = nn_prepare(M_yXYZ, metric);
    [~, distances] = nn_search(M_yXYZ, atria_yXYZ, (1:N)', k, 0);
    dd=distances(:,k);
    dd=dd.*(1-epsi);

    % range searches in subspaces of lower dimension
    atria_y = nn_prepare(M_y, metric);
    [count_y, ~] = range_search(M_y, atria_y, (1:N)', dd, 0);

    if ~isempty(M_XYZ)
        atria_XYZ = nn_prepare(M_XYZ, metric);
        [count_XYZ, tmp] = range_search(M_XYZ, atria_XYZ, (1:N)', dd, 0);
        %subtraction from count of points with distance exactly equal to k-th neighbor
        tmp=tmp(:,2);
        for n=1:length(tmp)
            count_XYZ(n)=count_XYZ(n)-sum(tmp{n}==dd(n));
        end
    else
        count_XYZ=NaN;
    end

    if ~isempty(M_Y)
        atria_Y = nn_prepare(M_Y, metric);
        [count_Y, tmp] = range_search(M_Y, atria_Y, (1:N)', dd, 0);
        %subtraction from count of points with distance exactly equal to k-th neighbor
        tmp=tmp(:,2);
        for n=1:length(tmp)
            count_Y(n)=count_Y(n)-sum(tmp{n}==dd(n));
        end
    else
        count_Y=NaN;
    end

    if ~isempty(M_YZ)
        atria_YZ = nn_prepare(M_YZ, metric);
        [count_YZ, tmp] = range_search(M_YZ, atria_YZ, (1:N)', dd, 0);
        %subtraction from count of points with distance exactly equal to k-th neighbor
        tmp=tmp(:,2);
        for n=1:length(tmp)
            count_YZ(n)=count_YZ(n)-sum(tmp{n}==dd(n));
        end
    else
        count_YZ=NaN;
    end

    if ~isempty(M_yY)
        atria_yY = nn_prepare(M_yY, metric);
        [count_yY, tmp] = range_search(M_yY, atria_yY, (1:N)', dd, 0);
        %subtraction from count of points with distance exactly equal to k-th neighbor
        tmp=tmp(:,2);
        for n=1:length(tmp)
            count_yY(n)=count_yY(n)-sum(tmp{n}==dd(n));
        end
    else
        count_yY=NaN;
    end

    if ~isempty(M_yYZ)
        atria_yYZ = nn_prepare(M_yYZ, metric);
        [count_yYZ, tmp] = range_search(M_yYZ, atria_yYZ, (1:N)', dd, 0);
        %subtraction from count of points with distance exactly equal to k-th neighbor
        tmp=tmp(:,2);
        for n=1:length(tmp)
            count_yYZ(n)=count_yYZ(n)-sum(tmp{n}==dd(n));
        end
    else
        count_yYZ=NaN;
    end
    cd(homeDir);

    %% compute PI and terms

    Py = psi(k) + psi(N) - (1/N)*( nansum(psi(count_y+1)) + nansum(psi(count_XYZ+1)) );

    Sy = psi(N) + (1/N)*( nansum(psi(count_yY+1)) - nansum(psi(count_y+1)) - nansum(psi(count_Y+1)) );

    Tzy = (1/N)*( nansum(psi(count_Y+1)) + nansum(psi(count_yYZ+1)) - nansum(psi(count_yY+1)) - nansum(psi(count_YZ+1)) );

    Txy_z = psi(k) + (1/N)*( nansum(psi(count_YZ+1)) - nansum(psi(count_yYZ+1)) - nansum(psi(count_XYZ+1)) );


    out.Ny=count_y;
    out.NXYZ=count_XYZ;
    out.NyY=count_yY;
    out.NY=count_Y;
    out.NyYZ=count_yYZ;
    out.NYZ=count_YZ;
    out.NyYZ=count_yYZ;
    out.NXYZ=count_XYZ;

return;






