function [count finalDistance neighbors] = nearNeiProbability (pointset,metric,k,funcDir)
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

    indices         = (1:size(pointset,1))';
    
    currDir         = pwd;
    cd(funcDir);
    atria                   = nn_prepare(pointset, metric);
    [index, distance]       = nn_search(pointset, atria,indices, k,0);
    
%     using pointset matrix without the target component
    pointsetSubspace        = pointset(:,2:end);
    atriaSubspace           = nn_prepare(pointsetSubspace, metric);
    [count, neighbors]      = range_search(pointsetSubspace, atriaSubspace,indices,distance(:,k),0);
    finalDistance           = distance(:,k);
    cd(currDir);

return;