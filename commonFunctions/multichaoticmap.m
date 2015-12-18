function [data] = multichaoticmap(n,c,s,eps,mu)
% eps              : 1 logistica  eps=0 tenda mu in [0,2]
% mu               : default 1.8
% c                : square matrix
    nvar = length(c);
    nt   = 1000;
    xx   = zeros(nvar,n+nt);
    cp   = c+diag(1-sum(c));
    test = 0.5;
    
    if (nargin < 5)
        mu = 1.8;
    end
    
    while test>0
        nn       = s*randn(nvar,n+nt-1);
        xx(:,1)  = rand(nvar,1);
        for i = 2:n+nt
            xx(:,i)    = cp'*(1-mu*abs(xx(:,i-1)).^(1+eps))+nn(:,i-1);
        end
        X     = xx(:,nt:n+nt-1);
        test  = isinf(max(max(abs(xx)))^2);
        if(test == 1)
            disp('the series tends towards infinite values');
            data = [];
            return;
%             break;
        else
%             figure
%             plot(X(1,:));
        end
    end
    data=zscore(X');

return;