function [out runParams]=wrapperUnsupMethods(X, runParams, globalParameters,dict)
%function out=wrapperUnsupMethods(X, runParams, dict)
decodingDict=[];
encodedData=[];
encodingDict=[];
out=struct;
funParams=struct;
funParams.runParams=runParams;
funParams.globalParameters=globalParameters;
if (nargin<4)
    %In this case the algorithm finds the encoding dictionary, the encoded
    %data and the decoding dictionary
    encodingDecodingFun=runParams.encodingDecodingFun;
    [decodingDict encodedData encodingDict]=encodingDecodingFun(X,funParams);
    out.decodingDict=decodingDict;
    out.encodedData=encodedData;
    out.encodingDict=encodingDict;
else
    %In this case the algorithm finds the encoded data: either dict is used
    %as a encodict dictionary or dict is used as fixed decoding dictionary
    funParams.dict=dict;
    encodingFun=runParams.encodingFun;
    encodedData=encodingFun(X,funParams);
    out.encodedData=encodedData;
end
