clear;

N        = 200;
p        = 36;
p_width  = 6;
p_height = 6;
dictSize     = 10;
numProcessor = 4;

X = randn(N,p);

settings=createUM_Settings_SAMPLE(dictSize,'./prova/',1,numProcessor);

execUnsupMethods(X, dictSize, './prova/', settings.params, numProcessor);

execUnsupMethods(X, dictSize, './prova2/', settings.params, numProcessor, './prova/');