function [threeDmtx] = make3Dmatrix(lableFolder,numDrivers,modelOrder,methodName)

    cd(lableFolder);
    targets = dir('id*.mat');
    numTargets = length(targets);
    
    threeDmtx = zeros(numTargets,numDrivers,modelOrder+1);
    
    for i = 1 : numTargets
        currLabelfile = dir(['id*_' num2str(i) '.mat']);
        load(currLabelfile.name);
        lengthIdSeriesLag = size(idSeriesLag,1);
        for j = 1 : lengthIdSeriesLag
            threeDmtx(i,idSeriesLag(j,1),idSeriesLag(j,2)+1) = idSeriesLag(j,3);
        end
    end
    
    save([methodName '_threeDmatrix'],'threeDmtx');
return;