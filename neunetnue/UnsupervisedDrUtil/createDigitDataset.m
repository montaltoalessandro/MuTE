function [train trainLab valid validLab test testLab]=createDigitDataset(Ntrain, Nvalid, Ntest)

%% LOADING DATA
% matData = load('/data/Documents/Datasets/Handwritten_Digits/MNIST/mnist_all.mat');
matData = load('/Users/alessandromontalto/Dropbox/Tesi_Magistrale/mnist_all.mat');

Ndigit = 10;

training{1}  = double(matData.train0)/255;
training{2}  = double(matData.train1)/255;
training{3}  = double(matData.train2)/255;
training{4}  = double(matData.train3)/255;
training{5}  = double(matData.train4)/255;
training{6}  = double(matData.train5)/255;
training{7}  = double(matData.train6)/255;
training{8}  = double(matData.train7)/255;
training{9}  = double(matData.train8)/255;
training{10} = double(matData.train9)/255;

testData{1}  = double(matData.test0)/255;
testData{2}  = double(matData.test1)/255;
testData{3}  = double(matData.test2)/255;
testData{4}  = double(matData.test3)/255;
testData{5}  = double(matData.test4)/255;
testData{6}  = double(matData.test5)/255;
testData{7}  = double(matData.test6)/255;
testData{8}  = double(matData.test7)/255;
testData{9}  = double(matData.test8)/255;
testData{10} = double(matData.test9)/255;


clear matData;

Ntrain4Digit = ceil(Ntrain / Ndigit);
Nvalid4Digit = ceil(Nvalid / Ndigit);
Ntest4Digit  = ceil(Ntest  / Ndigit);
Nfeatures = size(training{1},2);

train    = zeros(Ndigit * Ntrain4Digit, Nfeatures);
valid    = zeros(Ndigit * Nvalid4Digit, Nfeatures);
test     = zeros(Ndigit * Ntest4Digit,  Nfeatures);
trainLab = zeros(Ndigit * Ntrain4Digit,  1);
validLab = zeros(Ndigit * Nvalid4Digit,  1);
testLab  = zeros(Ndigit * Ntest4Digit,   1);

% Training
pos = 1;
for i=1:Ndigit
    for j=1:Ntrain4Digit
        train(pos,:) = training{i}(j,:);
        trainLab(pos) = i;
        pos = pos + 1;
    end
end

% Validation
pos = 1;
for i=1:Ndigit
    for j=1:Nvalid4Digit
        valid(pos,:) = training{i}(Ntrain4Digit+j,:);
        validLab(pos) = i;
        pos = pos + 1;
    end
end

% Test
pos = 1;
for i=1:Ndigit
    for j=1:Ntest4Digit
        test(pos,:) = testData{i}(j,:);
        testLab(pos) = i;
        pos = pos + 1;
    end
end


return;

