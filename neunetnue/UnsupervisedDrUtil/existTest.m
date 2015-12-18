function existFlag=existTest(outputFileName)        
    
    pcName       = getPcName();
 
    existFlag = 0;
    flagFileName = [outputFileName(1:end-4) '_' pcName '.flag'];
    
    if (~exist(flagFileName,'file') && ( exist(outputFileName,'file')  ||  existFlagFile(outputFileName)) )
        existFlag = 1;
    end    
        
    if (~existFlagFile(outputFileName) && ~exist(outputFileName,'file') && ~exist(flagFileName,'file'))
        writeFlagFile(flagFileName);        
    end    
        
 return;
 
 function flag=existFlagFile(outputFileName)
     flag = 0;
     files = dir([outputFileName(1:end-4) '*.flag' ]);
     if (~isempty(files))
         flag = 1;
     end     
 return;
 
 
 function writeFlagFile(flagFileName)
     
     index = strfind(flagFileName,'/');
     
     dirName = flagFileName(1:index(end));
     if ~exist(dirName,'file')
        [status,message,messageid] = mkdir(dirName);
     end
     
     file=fopen(flagFileName,'w');
     fclose(file); 
 return;