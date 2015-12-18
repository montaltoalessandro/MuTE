function idCandidates = unifyCandidates(numTargets,varargin)
% 
% Syntax:
% 
% [idCandidates]  = unifyCandidates(numTargets,varargin)
% 
% Description:
% 
% the function unifies the entries of the cell arrays in input
% 
% Input:
% 
% numTargets          : scalar indicating the number of targets chosen
% 
% varargin            : variable number of cell arrays given in input
% 
% Output:
% 
% idCandidates        : cell array containing, for each target, the 
%                       corresponding unified entries of the input cell
%                       arrays
% 
% Calling function:
% 
% generateConditionalTerm  ; generateCondTermLagZero

    
    if (length(varargin) < 2)
        fprintf('\n\n*********************************************************************\n');
        fprintf('***\n');
        fprintf('***  Not enough argument number\n***  Please consider a simple for loop to get the desidered output\n');
        fprintf('***\n');
        fprintf('*********************************************************************\n');
    end
    numCandidatesMtx    = size(varargin,2);
    idInCells           = 1:numCandidatesMtx;
    idCandidates        = cell(1,numTargets);
    initLength          = zeros(1,numCandidatesMtx);
    
    
    
%     initialyzing idCandidates
    for i = 1:numTargets
        for j = idInCells
            initLength(1,j)    = size(varargin{1,j}{1,i},1);
        end
        idCandidates{1,i}      = zeros(sum(initLength),2);
    end

%     building idCandidates
    for i = 1 : numTargets%parfor
        k = 1;
        for j = idInCells
            tmp        = size(varargin{1,j}{1,i},1);
            idCandidates{1,i}((k:(k-1)+tmp)',:) = varargin{1,j}{1,i};
            k = k + tmp;
        end
    end



return;