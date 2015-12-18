function printProgressBar(currentPos, maxPos)


if (currentPos > 0)
    deleteCurrPB();
else
    fprintf('\n\n|');
end

printCurrBar(currentPos,maxPos);
printCurrPerc(currentPos, maxPos);
    

if (currentPos >= maxPos)
    fprintf('| done\n');
end

return;

% function deleteCurrPerc()
%     for i=1:4
%         fprintf('\b');
%     end
% return;

function printCurrPerc(currentPos, maxPos)
    perc = round((currentPos / maxPos)*100);
    fprintf('%3d%%',perc);
return;

function printCurrBar(currentPos, maxPos)
    if (currentPos > 0)
        nBar = round((currentPos/maxPos)*10);
        %nBar
    else
        nBar = 0;
    end
    for i=1:nBar
        fprintf('=');
    end
    fprintf('>');
    for i=nBar+1:10
        fprintf(' '); 
    end
    fprintf('|');
return;

function deleteCurrPB()
    for i=1:16
        fprintf('\b');
    end
return;

