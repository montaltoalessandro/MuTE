function [data labels]=manageData(operation, sourceDestDir, data, labels)

params.rootDir        = sourceDestDir;
params.trainDir       = [params.rootDir '/Data_Train/'];
params.testDir        = [params.rootDir '/Data_Test/'];
params.dataTrainFile  = [params.trainDir 'data.mat'];
params.labelTrainFile = [params.trainDir 'label.mat'];
params.dataTestFile   = [params.testDir 'data.mat'];
params.labelTestFile  = [params.testDir 'label.mat'];


    switch (lower(operation))
        case 'gettrain'
            [data labels]=getTrain(params);
        case 'puttrain'
            putTrain(data, labels, params);
        case 'gettest'
            [data labels]=getTest(params);
        case 'puttest'
            putTest(data, labels, params);
        otherwise
            disp ('ERROR: unknown operation');            
    end

return;


function [data trainLabel]=getTrain(params)
    matData = load(params.dataTrainFile);
    data    = matData.data;
    
    matData = load(params.labelTrainFile);
    trainLabel    = matData.trainLabel;    

return;

function [data testLabel]=getTest(params)
    matData = load(params.dataTestFile);
    data    = matData.data;
    
    matData = load(params.labelTestFile);
    testLabel    = matData.testLabel;    

return;

function putTrain(data, trainLabel, params)
    
    [status,message,messageid] = mkdir(params.trainDir);
    save(params.dataTrainFile,'data');
    save(params.labelTrainFile,'trainLabel');

return;

function putTest(data, testLabel, params)
    
    [status,message,messageid] = mkdir(params.testDir);
    save(params.dataTestFile,'data');
    save(params.labelTestFile,'testLabel');

return;

