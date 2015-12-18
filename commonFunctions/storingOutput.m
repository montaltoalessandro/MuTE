function [] = storingOutput(resultDir,listRealizations,params,output)

    realizations = length(listRealizations);
    cd(resultDir);
    
    methodNames      = fieldnames(params.methods);
    numMethods       = length(methodNames);
    for i = 1 : realizations
        for j = 1 : numMethods
                if (strcmp('biv',params.methods.(methodNames{j}).multi_bivAnalysis))
                    outputToStore     = output{1,i}{1,j};
                    caseName                  = [methodNames{j} '_BivAnalysis_' listRealizations(i).name(1:end-4)];
                    save(caseName,'outputToStore');
                else
                    outputToStore     = output{1,i}{1,j};
                    caseName                  = [methodNames{j} '_MultivAnalysis_' listRealizations(i).name(1:end-4)];
                    save(caseName,'outputToStore');
                end
        end
    end

return