function [flag]=stopCriteria(t,ERRvalidation,stopIterToll)

flag=0;

if (t > 1)
    [minErr index]=min(ERRvalidation(1:t-1));

    if ((t-index)>stopIterToll)
        flag=1;        
    end
end

return;