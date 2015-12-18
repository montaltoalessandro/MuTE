function Error=RootMeanSquare(output,target)
% Error=RootMeanSquare(output,target)

SQE = SQError(output,target,1);
Error = sqrt(2*SQE/size(output,1));

return;