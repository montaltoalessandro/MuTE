function fig2png(folder,deleteFigFiles)
% function to convert .fig files in .png files inside a folder. It deletes
% the .fig files if deleteFiFiles = 1
%
% Syntax:
%
% fig2png(folder,deleteFigFiles)

    files = dir(fullfile(folder, '*.fig'));
    for k = 1 : length(files)
        open(fullfile(folder, files(k).name));
        saveas(gcf,fullfile(folder, strrep(files(k).name, '.fig', '.png')));
        close(gcf);
    end
    
    if (deleteFigFiles)
        delete('*.fig');
    end

return;