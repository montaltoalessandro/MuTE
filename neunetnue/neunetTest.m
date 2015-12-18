function [error] = neunetTest(network,data,idTargets,finalCandidates)

    % rearranging data according to finalCandidates
    [entropyMtx] = buildingEntropyMtx(data,idTargets,{finalCandidates});
    
    % feeding the network with entropyMtx
    expectedOutput = entropyMtx{1,1}(1,:)';
    networkInput   = entropyMtx{1,1}(2:end,:)';
    output         = ffwSim(network, networkInput);
    
    % evaluating the error
    error          = RMSError(output, expectedOutput);

return;