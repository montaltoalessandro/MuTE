function fileName = getFileName(baseName, paramId)
    fileName  = [baseName '_'];
    
    for i=1:length(paramId)
        fileName  = [fileName int2str(paramId(i))];        
    end
    
    fileName  = [fileName '.mat'];
         
return;