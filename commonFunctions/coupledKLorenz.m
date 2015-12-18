function [xM] = coupledKLorenz(n,K,ts,epsilonV)
% function [xM] = coupledKLorenz(n,K,ts,epsilonV)
% K-coupled Lorenz system X(1)->X(2), X(2)->X(3), ... X(K-1)->X(K)
% INPUTS
% - n  : time series length
% - K  : number of Lorenz subsystems to be coupled
% - ts : sampling time (best to use 0.05)
% - epsilonV: vector of coupling strengths of length K-1
% in simulations, we use the same coupling strength epsilon = 0,1,2,3,4,5,6
% OUTPUTS
% - xM : matrix (n x K) of the X-variables from each Lorenz subsystem

x0limM = [-10 10; -20 20; 5 30];
x0V = NaN*ones(K*3,1);
for i=1:3
    x0V(i:3:3*K) = rand(K,1)*(x0limM(i,2)-x0limM(i,1))+x0limM(i,1);
end
epsilonV = epsilonV(:);
omega = [10 28 8/3 epsilonV']; 

ntrans = 1000;
T = (n+ntrans)*ts;
[t,yM] = ode45(@odefun,(0:ts:T),x0V,[],omega);
xM = yM(ntrans+1:(n+ntrans),:);
xM = xM(:,1:3:end);
% xM = xM(:,3:3:end);

function dy = odefun(t,y,omega)
sigma = omega(1);
r = omega(2);
b = omega(3);
epsilonV = omega(4:end);
dy = [ -sigma * y(1) + sigma * y(2); ...
       -y(1) * y(3) + r* y(1) - y(2); ...
              y(1) * y(2) - b* y(3) ];
K = length(epsilonV)+1;          
for i=2:K
    dynow = [-sigma*y((i-1)*3+1)+sigma*y((i-1)*3+2)+epsilonV(i-1)*(y((i-2)*3+1)-y((i-1)*3+1)); ...
        -y((i-1)*3+1) * y((i-1)*3+3) + r* y((i-1)*3+1) - y((i-1)*3+2); ...
        y((i-1)*3+1) * y((i-1)*3+2) - b*y((i-1)*3+3)];
    dy = [dy; dynow];
end

return;