function performance=computePerformance(coeff,funParams)
% function perfomance=computePerformance(coeff,funParams)
% funParams.dict;
% funParams.globalParameters.data;

    dict        = funParams.dict;
    X           = funParams.globalParameters.dataWithoutNoise;
    index       = funParams.globalParameters.valNoZeroIndeces(1,:);
    [N d]       = size(X);
    one_        = ones(1,d);
    one_(index) = 0;
    index       = find(one_);
    out         = coeff * dict';
    %out         = X;

    %for i=1:N
    %	out(i,index) = out_2(i,index);
    %end

    [mean_ std_]= computeError(X,out,index);
%     
%     [N d]       = size(X);
%     diff        = X-out;
%     error       = zeros(1,N);
%     dim         = sqrt(d);
%     for i=1:N
%         % error(i) = sqrt(norm(diff(i,:))/d);
%         error(i) = sqrt(norm(reshape(diff(i,:),dim,dim)','fro')/d);
%     end
    score       = mean_;
    score_std   = std_;
    
    %score       = sqrt(norm(X-out,'fro')/N);
    %score       = RMSError(out,X);

    binCoeff    = ~(coeff == 0);
    meanUsed    = mean(sum(binCoeff));
    sparsity    = meanUsed / size(dict,2);

    performance.score     = score;
    performance.score_std = score_std;
    performance.sparsity  = sparsity;

return
