function [mean_ std_]=computeError(X,out,index)
% [mean_ std_]=computeError(X,out,index)

    [N d]       = size(X);
    diff        = X-out;
    error       = zeros(1,N);
    dim         = sqrt(d);
    len_index   = length(index);
    for i=1:N
        % error(i) = sqrt(norm(diff(i,:))/d);
        % error(i) = sqrt(norm(diff(i,index))/len_index);
        error(i) = sqrt(norm(reshape(diff(i,:),dim,dim)','fro')/d);
    end
    mean_       = mean(error);
    mean_       = RMSError(out,X);
    std_        = std(error);
    
  
return
