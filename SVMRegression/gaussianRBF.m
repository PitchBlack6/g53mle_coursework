train_size = 10000;
test_size = 1000;

label = csvread('angle.csv',1,0);
featureX = load('predx_for_classification.csv');
featureY = load('predy_for_classification.csv');
disp('Data Loaded');

featureX = normaliseData(featureX);
featureY = normaliseData(featureY);
disp('Data Normalized');

% get first column
labels = label(:,1);

% transpose 
% labels = temp.';

features = [featureX featureY];

% Shuffle data
% [features, labels] = shuffleData(features, labels);
% disp('Data Shuffled');

% Train test split
trainFeatures = features(1:train_size, :);
trainLabels = labels(1:train_size);
disp(max(trainLabels));
testFeatures = features(train_size+1:train_size+test_size, :);
testLabels = labels(train_size+1:train_size+test_size);
disp('Data Split');

% k-fold
[trainFeatures, trainLabels] = splitDataset(trainFeatures, trainLabels);

% Model 1
sumWeights = 0;
sumBias = 0;
sumRMSE = 0;
sumVectors = 0;

% Cross-validate two SVM regression models using 5-fold cross-validation. 
% For both models, specify to standardize the predictors. 
% For one of the models, specify to train using the default linear kernel, and the Gaussian kernel for the other model.
% Mdl = fitrsvm(trainFeatures,trainLabels, 'Standardized', true, 'Kfold', 5);

% train data
disp('train data');
for n = 1:10 
    dummyFeature = trainFeatures;
    dummyFeature(n, :, :) = [];
    dummyLabel = trainLabels;
    dummyLabel(n, :, :) = [];
    
    currentTrainFeatures = reshape(dummyFeature, size(trainFeatures, 2) * 9, size(trainFeatures, 3));
    currentTrainLabels = reshape(dummyLabel, size(trainLabels, 2)*9, size(trainLabels, 3));
    
    % using standardized data gives lower average RMSE
    Mdl1 = fitrsvm(currentTrainFeatures, currentTrainLabels, 'KernelFunction','gaussian','KernelScale',2.0,'BoxConstraint', 1);
    sigma = Mdl1.Sigma;
    
    % sumWeights = sumWeights + Mdl1.Beta;
    sumBias = sumBias + Mdl1.Bias;
    
    % make predictions using support vectors
    predictions = predict(Mdl1, testFeatures);
    
    % get RMSE by comparing predictions with testLabels
    sumRMSE = sumRMSE + sqrt(mean((predictions - testLabels).^2));
    
    sv = size(Mdl1.SupportVectors,1);
    sumVectors = sumVectors + sv;
   
end

% get size of observations
obs = size(currentTrainFeatures,1);
disp(obs);

% get average support vectors
avgSV = sumVectors/10;

% get percent
output = calculatePercentSupportVector(avgSV, obs);

% disp average RMSE
disp(sumRMSE/10);

fprintf('Percentage: %f\n', output);






