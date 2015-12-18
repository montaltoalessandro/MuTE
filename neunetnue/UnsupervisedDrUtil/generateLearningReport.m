function generateLearningReport(params, learnOutputDir, expFolder)
% function generateLearningReport(params, learnOutputDir, expFolder)

methodNames = getMethodNames(params);
dictSize    = params.globalParameters.dictSize;

close all;
h=figure;

outFolder = [learnOutputDir '/Report/'];
mkdir(outFolder);

file = fopen([outFolder '/report.txt'],'w');
method = 'Dict number';
perf   = 'Sparsity';
area   = 'Sparsity area';
fprintf(file,'%15s \t %15s \t %15s\n',method,perf,area);
fprintf(file,'--------------------------------------------------------\n');

xRange = linspace(0.01, 0.1, 100);

for i=1:length(methodNames)
    numDict  = 1;
	methodName = methodNames{i};	
	out        = getLearningCoeffAndDict(expFolder,methodName,dictSize,numDict);
	c_folder   = [outFolder methodName];
	mkdir(c_folder);

	count=0;
	while not(isempty(out))
		dict  = out.dict;
		coeff = out.coeff;

		coeffbin  = abs(coeff) > 0;
		usage     = sum(coeffbin,1);
		meanUsed  = mean(sum(coeffbin'));
	        sparsity  = meanUsed / dictSize;
		[v index] = sort(usage,'descend');
		dictOrder = dict(:,index);
		p_row     = sqrt(size(dictOrder,1));	% DA CAMBIARE
  		p_col     = p_row;		% DA CAMBIARE
 		I_dict    = displayDictionary(dictOrder,p_row,p_col);
 		imshow(I_dict);
 		title('Dictionary');
% 		saveas(h,[c_folder '/dictionary_' int2str(numDict) '.png']);
        print(h, '-deps', [c_folder '/dictionary_' int2str(numDict)]);

		[area] = getSparsityArea(coeff, xRange);

		fprintf(file,'%15s \t %.3f \t %.3f\n',methodName,sparsity,area);

	    numDict  = numDict+1;
	    out      = getLearningCoeffAndDict(expFolder,methodName,dictSize,numDict);
	end
end

close all;
fclose(file);








