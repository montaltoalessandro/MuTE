function [entropyTerm distance]  = evalNearNeiConditionalEntropy(pointset,metric,k,funcDir,homeDir,distance)

    N               = size(pointset,1);
    indices         = 1:N;
    
    %% Evaluate psi function
    psiVar = psi(1:N);
    cd(funcDir);
    if (nargin < 6)
        %% Evaluating the number of points in the range of the k-th nearest neighbor
        [count distance] = nearNeiProbability (pointset,metric,k,funcDir);

        %% Evaluate conditional entropy

        entropyTerm = -psiVar(k) + (1/N) * sum(psiVar(count+1)) + (1/N) * sum(log(2*distance));
    else
        %% 
        
        atria                   = nn_prepare(pointset, metric);
        count2                  = range_search(pointset, atria,indices,distance,0);
        pointsetSubspace        = pointset(:,2:end);
        atriaSubspace           = nn_prepare(pointsetSubspace, metric);
        count                   = range_search(pointsetSubspace, atriaSubspace,indices,distance,0);
        entropyTerm             = (1/N) * (sum(psiVar(count+1)) - sum(psiVar(count2+1))) + (1/N) * sum(log(2*distance));
    end
    cd(homeDir);
    
return;