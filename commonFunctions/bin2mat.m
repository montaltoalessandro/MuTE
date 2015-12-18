function [] = bin2mat(folder,fileName,deleteBinFiles)
% function to convert .bin files in matlab readable format files 
% inside a folder. It deletes the .fig files if deleteFiFiles = 1
%
% Syntax:
%
% fig2png(folder,deleteFigFiles)

    files = dir(fullfile(folder, '*.bin'));
    for k = 1 : length(files)
        for i=1%:10
            disp(i)
            fid         = fopen(strcat([folder '/'],fileName,num2str(k),'.bin'),'r');
            data        = reshape(fread(fid,'float'),[],19);
            nameFile    = files(k).name(1:strfind(files(k).name,'.')-1);
            save(nameFile,'data');
        end
    end
    
    if (deleteBinFiles)
        delete('*.bin');
    end

return;