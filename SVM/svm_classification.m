% Hyper-parameters
train_size = 2000;
test_size = 2000;
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

[trainFeatures, trainLabels] = spiltDataset(trainFeatures, trainLabels);

% Model 1
sumWeights = 0;
sumBias = 0;
sumMeasure = 0;
for n = 1 : 10
    currentTrainFeatures = reshape(trainFeatures(n, :,  :), size(trainFeatures, 2), size(trainFeatures, 3));
    currentTrainLabels = reshape(trainLabels(n, :,  :), size(trainLabels, 2), size(trainLabels, 3));
    Mdl1 = fitcsvm(currentTrainFeatures, currentTrainLabels, 'KernelFunction', 'linear', 'BoxConstraint', 1);
    sumWeights = sumWeights + Mdl1.Beta;
    sumBias = sumBias + Mdl1.Bias;
    predictions = predict(Mdl1, testFeatures);
    [~, ~, measure] = ConfusionMatrixFunc(predictions, testLabels);
    sumMeasure = sumMeasure + measure;
end
disp(sumMeasure/10);

avgWeights = sumWeights/10;
aveBias = sumBias/10;

predictions = 1 : length(testLabels);
for i = 1 : size(testFeatures)
    score = testFeatures(i, :) * avgWeights + aveBias;
    if score > 0
        predictions(i) = 1;
    else
        predictions(i) = 0;
    end
end

[~, ~, measure] = ConfusionMatrixFunc(predictions, testLabels);
disp(measure);



% Model 2
%Mdl2 = fitcsvm(trainFeatures, trainLabels, 'KernelFunction', 'gaussian', 'BoxConstraint', 1);
%CVSVMModel = crossval(Mdl2);
%classLoss = kfoldLoss(CVSVMModel);
%disp("Gaussian Model Loss: " + classLoss);

% Model 3
%Mdl3 = fitcsvm(trainFeatures, trainLabels, 'KernelFunction', 'rbf', 'BoxConstraint', 1);

%predictions = predict(Mdl3, testFeatures);

%[precision, recall, measure] = ConfusionMatrixFunc(predictions, testLabels);
%disp(precision);
%disp(recall);
%disp(measure);

% Model 4
% Mdl4 = fitcsvm(trainFeatures, trainLabels, 'KernelFunction', 'polynomial', 'BoxConstraint', 1);
% CVSVMModel = crossval(Mdl4);
% classLoss = kfoldLoss(CVSVMModel);
% disp("Polynomial Model Loss: " + classLoss);


