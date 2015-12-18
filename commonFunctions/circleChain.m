function data = circleChain(n,m,C,rho)


P = 2;


ntrans            = 10; % transient period
wM                = randn(m,n+ntrans);
data              = zeros(m,n+ntrans);
data(:,1:P)       = wM(:,1:P);
sqrt2             = sqrt(2);


for t=P+1:n+ntrans
    data(1,t) = sqrt2*rho*(0*data(m,t-1) + (1-0)*data(1,t-1)) - (rho^2)*data(1,t-2) + wM(1,t);
    for idSeries = 2:m
        data(idSeries,t) = sqrt2*rho*(C*data(idSeries-1,t-1) + (1-C)*data(idSeries,t-1)) - (rho^2)*data(idSeries,t-2) + wM(idSeries,t);
    end
end;
data = data(:,ntrans+1:n+ntrans);

figure
plot(data(m,:))

return;