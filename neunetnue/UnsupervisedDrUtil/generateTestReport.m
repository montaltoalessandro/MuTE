function generateTestReport(params, expFolder, patchesDataTest, patchesDataTestWithNoise)
%function generateTestReport(params, expFolder, learnOutputDir)

p_row = 8; % PLEASE CHANGE !!!
p_col = 8;

d           = size(patchesDataTest,2);
index       = params.globalParameters.valNoZeroIndeces(1,:);
one_        = ones(1,d);
one_(index) = 0;
index       = find(one_);
[mean_ std_]= computeError(patchesDataTest,patchesDataTestWithNoise,index);
dictSize=params.globalParameters.dictSize;
% Chiamo readPerfomances

methodNames=getMethodNames(params);

if not(expFolder(end)=='/')
    expFolder=[expFolder '/'];
end

outDir = [expFolder 'Report_with_dict_' num2str(dictSize)];

mkdir(outDir);

file = fopen([outDir '/report.txt'],'w');
method  = 'Method Name';
dictNum = 'Dict #';
perf    = 'Performance (mean | std )';
fprintf(file,'%15s \t %15s \t%15s\n',method,perf,dictNum);
fprintf(file,'--------------------------------------------------------\n');
fprintf(file,'INITIAL ERROR = %.5f %.5f\n',mean_,std_);
fprintf(file,'--------------------------------------------------------\n');
%close all;
%h = figure;
%set(h,'Position',[1 1 1280 1024]);
%I_data = displayDictionary(patchesDataTest',p_row,p_col);
%imshow(I_data);
%title('Original test data');
%print(h, '-deps', [outDir '/test_original_data']);

%I_data = displayDictionary(patchesDataTestWithNoise',p_row,p_col);
%imshow(I_data);
%title('Currupted test data');
%print(h, '-deps', [outDir '/test_currupted_data']);

for i=1:length(methodNames)
    result=readPerformancesTest(expFolder,methodNames{i},dictSize);
    %rec_data = result.coeff * result.dict';
    %I_data = displayDictionary(rec_data',p_row,p_col);
    %imshow(I_data);
    %title(['Reconstructed data by ' methodNames{i}]);
    %print(h, '-deps', [outDir '/test_rec_data_' methodNames{i}]);
    fprintf(file,'%15s \t %.5f %.5f\t %d\n',methodNames{i},result.performance.score,result.performance.score_std,result.dictNum);
end

fclose(file);

return;
