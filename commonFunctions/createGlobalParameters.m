function globalParameters   = createGlobalParameters()
% 
% Syntax:
% 
% globalParameters   = createGlobalParameters()
% 
% Description:
% 
% you can choose to set the parameters that hold for each method. For
% instance the number of processor to run the methods in a parallel session
% 
% globalParameters               = struct;
% *** Necessary Fields ***
% globalParameters.numProcessor  = 4;      
% globalParameters.outDir        = 'output dir path' in this directory the
%                                  it will be created a forlder for each
%                                  method. In this folder it will be stored
%                                  a structure with all interesting results
% ************************
% golbalParameters.nameField     = ...;

globalParameters             = struct;

return;