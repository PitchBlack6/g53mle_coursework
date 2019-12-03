train_size = 10000;
test_size = 1000;

label = csvread('angle.csv',1,0);
%label1 = label(:,1);
%label2 = label(:,2);
%label3 = label(:,3);
%label4 = label(:,4);
%label5 = label(:,5);
featureX = load('predx_for_classification.csv');
featureY = load('predy_for_classification.csv');
disp('Data Loaded');

featureX = normaliseData(featureX);
featureY = normaliseData(featureY);
disp('Data Normalized');

% get first column
temp = label(:,1);

% transpose 
labels = temp.';

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

% Cross-validate two SVM regression models using 5-fold cross-validation. 
% For both models, specify to standardize the predictors. 
% For one of the models, specify to train using the default linear kernel, and the Gaussian kernel for the other model.
% Mdl = fitrsvm(trainFeatures,trainLabels, 'Standardized', true, 'Kfold', 5);

Mdl = fitrsvm(trainFeatures,trainLabels, 'KernelFunction', 'gaussian', 'BoxConstraint', 1);
disp('Data trained');

Mdl.ConvergenceInfo.Converged;
iter = Mdl.NumIterations;



% Compute the resubstitution (in-sample) mean-squared error for the new model.
lStd = resubLoss(Mdl);
disp(lStd);
fprintf('Num of iterations for convergence: %d', iter);

% make predictions
predictions = predict(Mdl, testFeatures);
% disp(predictions);
RMSE = sqrt(mean((predictions - testLabels).^2));
disp(mean(RMSE));
