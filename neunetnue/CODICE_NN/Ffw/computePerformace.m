function [E_T RMSE_T E_V RMSE_V]=computePerformace(ffwNet,learnParams)
% function [SQE SQEV]=computePerformace(ffwNet,learnParams)

% if (nargin == 3)
%     out    = params.trainSet * W0';
%     out_hl = params.trainSet;
% elseif (nargin == 4)
%     [out tmp1 out_hl tmp2]   = ffwForwardStepMat(params.trainSet, W0, params.actFuncHL, W1, params.actFuncOL);
% else
%     [out tmp1 out_hl tmp2]   = ffwForwardStepMat(params.trainSet, W0, B0, params.actFuncHL, W1, B1, params.actFuncOL);
% end
	trainSet        = learnParams.trainSet;
	trainTarget     = learnParams.trainTarget;
	ts_output       = ffwSim(ffwNet, trainSet);
	errorFunction   = learnParams.errorFunction;

	E_T             = errorFunction(ts_output,trainTarget);
	if ~isfield(learnParams,'kernelsNumber')
		RMSE_T          = RMSError(ts_output,trainTarget,1);
	else
		RMSE_T          = zeros(size(E_T));
	end

	if (learnParams.useValidation == 0)
		E_V  = 0;
		RMSE_V = 0;
	else
		validSet        = learnParams.validSet;
		validTarget     = learnParams.validTarget;
		vs_output       = ffwSim(ffwNet,validSet);
		%SQEV  = sum(SQError(out_v,params.validTarget,1));
		E_V             = errorFunction(vs_output,validTarget,1);
		if ~isfield(learnParams,'kernelsNumber')
			RMSE_V          = RMSError(vs_output,validTarget,1);
		else
			RMSE_V          = zeros(size(E_V));
		end
	end
return;