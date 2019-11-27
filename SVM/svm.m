% Hyper-parameters
train_size = 2000;
test_size = 20000;
% Load data
label = load('label.csv');
label1 = label(:,1);
label2 = label(:,2);
label3 = label(:,3);
label4 = label(:,4);
label5 = label(:,5);
featureX = load('predx_for_classification.csv');
featureY = load('predy_for_classification.csv');
disp('Data Loaded');

% Normalise x and y
featureX = normaliseData(featureX);
featureY = normaliseData(featureY);
features = [featureX featureY];
[features, label1] = shuffleData(features, label1);

trainFeatures = features(1:train_size, :);
trainLabels = label1(1:train_size, :);
testFeatures = features(train_size+1:train_size+test_size, :);
testLabels = label1(train_size+1:train_size+test_size, :);
disp('Data Normalized');

Mdl = fitcsvm(trainFeatures, trainLabels, 'KernelFunction', 'linear', 'BoxConstraint', 1);
CVSVMModel = crossval(Mdl);
classLoss = kfoldLoss(CVSVMModel);

disp(Mdl);
disp(classLoss);