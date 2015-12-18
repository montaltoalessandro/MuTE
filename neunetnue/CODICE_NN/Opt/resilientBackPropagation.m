function [W learnParams ] = resilientBackPropagation(W,gradW,learnParams)
%   function [W learnParams ] = resilientBackPropagation(W,gradW,learnParams)
    if (isfield(learnParams,'RBPParam'))
        RBPParam=learnParams.RBPParam;
    else
       RBPParam=createRBPParam();
    end
    deltaInit=RBPParam.deltaInit;
    deltaMin  = RBPParam.deltaMin;
    deltaMax  = RBPParam.deltaMax;
    etaP      = RBPParam.etaP;
    etaN      = RBPParam.etaN;
   numParamMatrices=length(W); 
   if (isfield(learnParams,'deltaRBP'))
         deltaRBP=learnParams.deltaRBP;
         prevGrad=learnParams.prevGrad;
   else
         
         prevGrad=cell(1,numParamMatrices);
         deltaRBP=cell(1,numParamMatrices);
         for i=1:numParamMatrices
             deltaRBP{i}=ones(size(W{i})) * deltaInit;
             prevGrad{i}=zeros(size(W{i}));
         end
        setLearnParams(learnParams,'deltaRBP',deltaRBP);
        setLearnParams(learnParams,'prevGrad',prevGrad);

   end
    
    for i=1:numParamMatrices
       
        c_W=W{i};
        c_grad=gradW{i};
        c_grad_prec=prevGrad{i};
        c_delta_RBP=deltaRBP{i};
        dot_grad= c_grad .* c_grad_prec;
        ind_gt_0    = find(dot_grad > 0);
        ind_le_0    = find(dot_grad < 0);
        ind_eq_0    = find(dot_grad == 0);
        c_delta_RBP(ind_gt_0) = min(etaP*c_delta_RBP(ind_gt_0),deltaMax);        
        c_grad_prec(ind_gt_0) = c_grad(ind_gt_0);        
        c_W(ind_gt_0)           = c_W(ind_gt_0) - sign(c_grad(ind_gt_0)) .* c_delta_RBP(ind_gt_0);
        c_delta_RBP(ind_le_0) = max(etaN*c_delta_RBP(ind_le_0),deltaMin);
        c_grad_prec(ind_le_0) = 0;
        c_grad_prec(ind_eq_0) = c_grad(ind_eq_0);
        c_W(ind_eq_0)           = c_W(ind_eq_0) - sign(c_grad(ind_eq_0)) .* c_delta_RBP(ind_eq_0);
        W{i}        = c_W;        
        learnParams.deltaRBP{i}=c_delta_RBP;
        learnParams.prevGrad{i}=c_grad_prec;
    end

return;
