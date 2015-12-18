function deleteFlagFileName(outputFileName)

pcName = getPcName();

flagFileName = [outputFileName(1:end-4) '_' pcName '.flag'];

delete(flagFileName);

return;