function [B] = getSeriesToProcess(A)
% 
% Syntax:
% 
% [B] = getSeriesToProcess(A)
% 
% Description:
% 
% the function takes from the matrix A all its entries, greater than zero,
% once, returning them in the vector B
% 
% Input:
% 
% A                  : matrix data
% 
% Output:
% 
% B                  : vector
% 
% Calling function:
% 
% quantization


    [idRowNonZeroentries idColNonZeroentries]   = find(A ~= 0);

    idNonZeroEntries                            = [idRowNonZeroentries idColNonZeroentries];

    whileConditionMtx                           = idNonZeroEntries;
    maxEntry                                    = max(A(:));
    B                                           = zeros(maxEntry,1);

%%     getting the id series once
    j = 1;
    while ~isempty(whileConditionMtx)
        B(j,1)                           = A(whileConditionMtx(1,1),whileConditionMtx(1,2));
        [tmpIdFirstCol tmpIdSecondCol]   = find(A == B(j,1));
        numCurrElements                  = length(tmpIdFirstCol);
        tmpIdCurrElements                = zeros(numCurrElements,1);
        for i = 1 : numCurrElements%parfor
            tmpIdCurrElements(i,1)       = strmatch([tmpIdFirstCol(i,1) tmpIdSecondCol(i,1)],whileConditionMtx);
        end
        whileConditionMtx(tmpIdCurrElements,:) = [];
        j = j + 1;
    end

    [idCurrElemnt ~]     = find(B > 0);
    B    = B(idCurrElemnt,1);

return;