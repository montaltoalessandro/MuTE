function [entropyTerm] = nearNeiShannonEntropy (pointset,metric,k,funcDir,homeDir)
% 
% 
% Syntax : 
% 
% function [atria distance neighbours] = nearNeiProbability (pointset,metric,queryPoints,k)
% 
% Description :
% 
% Input :
% 
% Output :
% 
% Calling function :
% 
% 
    N               = size(pointset,1);
    indices         = (1:N)';
    cd(funcDir);
    %% Evaluate psi function
    psiVar = psi(1:N);
    %% Evaluate the Shannon Entropy
    atria               = nn_prepare(pointset, metric);
    [~, distance]       = nn_search(pointset, atria, indices, k,0);
    entropyTerm         = -psiVar(k) + psiVar(N) + (1/N) * sum(log(2*distance(:,k)));
    cd(homeDir);
    
return;