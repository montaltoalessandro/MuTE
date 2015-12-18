function accuracy=generateResults(inputDir, outputDir, row, col)
% accuracy=generateResults(inputDir, outputDir, row, col)

if (~exist(inputDir))
    fprintf('ERROR: inputDir does not exist!\n')
    return;
end


mkdir(outputDir);

dirList = dir(inputDir);

dictDir = [outputDir 'Dict/'];

mkdir(dictDir);

close all;
h=figure;
colormap gray;

acc_file = fopen([outputDir 'output.txt'],'w');
for i=3:length(dirList)
    c_inputDir = [inputDir dirList(i).name '/'];
    methodName = manageMethods('getMethodsList', c_inputDir); 
           
    pos = strfind(c_inputDir,'_');
    dictSize = str2num(c_inputDir(pos(end)+1:end-1));
    
    fprintf('\n\nCLASSIFICATION ... %d\n',dictSize);
        
    % for each method
    for j=1:length(methodName)            
            
        fprintf('Method name: %s\n',methodName{j});
            
        outputFileName = [c_inputDir '/Classification/accuracy_' methodName{j} '.mat'];        
        matData        = load(outputFileName);
        
        for k=1:length(matData.accuracy)
            [maxAcc n] = min(matData.accuracy{k});
            accuracy{k}(i-2,j) = maxAcc;
            numParams  = length(matData.accuracy{k});
            dict       = manageDict('get',c_inputDir,methodName{j},int2Vect(n,numParams), dictSize);
            I          = displayDictionary(dict, row, col);
            imagesc(I);
            dictFile   = [dictDir methodName{j} '_' int2str(dictSize) '_t_' int2str(k)];
            print(h,'-depsc',dictFile);
            
            fprintf(acc_file,'TRAIN DATA %d | Dict Size %d | Method: %s\n',k,dictSize,methodName{j});
            
            fprintf(acc_file,'%2.3f\n',maxAcc);            
            
            
        end
        
    end
    
end
fclose(acc_file);

numPlots = length(accuracy);
close all;
h = figure;
for i=1:numPlots    
    subplot(1,numPlots,i);
    bar(accuracy{i});    
end
legend(methodName);
%outFile   = [dictDir methodName '_ACC_' int2str(dictSize) '_t_' int2str(k)];
%print(h,'-dpesc',outFile);


return;