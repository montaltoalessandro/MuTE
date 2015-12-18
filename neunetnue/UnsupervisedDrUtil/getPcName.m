function pcName=getPcName()

    [tmp pcName] = system('uname -a');
    endPcName    = strfind(pcName,'#');
    pcName       = pcName(1:endPcName-2);
 
return;
