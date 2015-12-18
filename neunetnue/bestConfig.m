function [config] = bestConfig(A)

    [row,col]     = size(A);
    
    [sortedA sortedIdA]   = sort(A,2);
    
    configMtx     = zeros(row,col+1+row);
    
    i = 1;
    while (~isempty(sortedIdA))
        currId             = sortedIdA(1,:);
        matchesId          = strmatch(currId,sortedIdA);
        numId              = length(matchesId);
        configMtx(i,1:col+1+numId)     = [currId numId matchesId'];
        sortedIdA(matchesId,:) = [];
        i = i + 1;
    end
    
    [maxIns,idConfig] = max(configMtx(:,end));
    
    config            = configMtx(idConfig(1,1),:);

return;