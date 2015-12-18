function error=getClassifierError(trueLabels, classifierLabels)
    
    labels = unique(trueLabels);
    occurrence = zeros(1,length(labels));
    for i=1:length(labels)
        occurrence(i) = length(find(trueLabels == labels(i)));
    end
    
    correct = zeros(1,length(labels));
    pos = 1;
    for c=1:length(labels)
        for i=1:occurrence(c)
            if (trueLabels(pos) == classifierLabels(pos))
                correct(c) = correct(c) + 1;
            end
            pos = pos + 1;
        end
    end
    
    perf = mean(correct ./ occurrence);
    
    error = 1 - perf;
    
return;