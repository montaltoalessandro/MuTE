function [data] = generateTS(N,settleTime,nonLinear)
% function [data] = generateTimeSeries(N,settleTime,nonLinear)

% nonLinear = false;    %set to true for nonlinear model
% N=10000;             %number of points of simulated time series
% settleTime=1000;    %settling time
%create a null distribution with randomized phases. this is not always
%necessary, since there is already the test on the coefficients, but it's good to have
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = N + settleTime;
X = randn(5,N);
r = sqrt(2);
if nonLinear
    
    %%%%%% nonlinear case, so you can see that it works better with p=2
    for i=4:N,
        X(1,i) = X(1,i) + 0.95.*r.*X(1,i-1) - 0.9025.*X(1,i-2);
        X(2,i) = X(2,i) + 0.5.*X(1,i-2)^2;
        X(3,i) = X(3,i) - 0.4.*X(1,i-3);
        X(4,i) = X(4,i) - 0.5.*X(1,i-2)^2 + 0.5.*r.*X(4,i-1) + 0.25.*r.*X(5,i-1);
        X(5,i) = X(5,i) - 0.5.*r.*X(4,i-1) + 0.5.*r.*X(5,i-1);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    %%%%%% linear influences only
    for i=4:N,
        X(1,i) = X(1,i) + 0.95.*r.*X(1,i-1) - 0.9025.*X(1,i-2);
        X(2,i) = X(2,i) + 0.5.*X(1,i-2);
        X(3,i) = X(3,i) - 0.4.*X(1,i-3);
        X(4,i) = X(4,i) - 0.5.*X(1,i-2) + 0.25.*r.*X(4,i-1) + 0.25.*r.*X(5,i-1);
        X(5,i) = X(5,i) - 0.25.*r.*X(4,i-1) + 0.25.*r.*X(5,i-1);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
end
X = X(:,settleTime+1:end);
data=X';            %data matrix must have the dimensions [n_points n_variables]

return;