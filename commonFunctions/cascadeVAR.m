function data = cascadeVAR(n,m,C,rho)


P = 2;


ntrans            = 1000; % transient period
wM                = randn(m,n+ntrans);
data              = zeros(m,n+ntrans);
data(:,1:P)       = wM(:,1:P);
sqrt2             = sqrt(2);


for t=P+1:n+ntrans
    data(1,t) = sqrt2*rho*data(1,t-1) - (rho^2)*data(1,t-2) + wM(1,t);
    for idSeries = 2:m-1
        data(idSeries,t) = 0.5*C*(data(idSeries-1,t-1) + data(idSeries+1,t-1)) + (1-C)*sqrt2*rho*data(idSeries,t-1) - (rho^2)*data(idSeries,t-2) + wM(idSeries,t);
    end
    data(m,t) = sqrt2*rho*data(m,t-1) - (rho^2)*data(m,t-2) + wM(m,t);
end;
data = data(:,ntrans+1:n+ntrans);

% for i = 1 : m
%     figure
%     plot(data(i,:))
% end