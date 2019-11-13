toLoadModel = false;
% Hyper parameters
train_size = 64000;
test_size = 16000;
% The value of the entropy that is considered good enough. Training the
% tree to a value of 0 entropy would take too long and lead to overfitting.
minimumEntropy = 0.01;
% The threshold ranges between 0 and 1. We can't possible test all the
% values in between, so we need to set the increment value. The lower the
% value, the more precise the results will be, but it would take long to
% train. A low threshold value would also lead to overfitting.
thresholdIncrement = 0.01;

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
trainFeatures = features(1:train_size, :);
trainLabels = label1(1:train_size, :);
testFeatures = features(train_size+1:train_size+test_size, :);
testLabels = label1(train_size+1:train_size+test_size, :);
disp('Data Normalized');

if toLoadModel
    % Load model
    disp("Loading Model")
    model = load('model.csv');
    head_node = node;
    head_node = head_node.loadModel(model);
else
    % Create tree
    disp('Creating Tree');
    tic
    node.setgetNodeCounter(0);
    head_node = node;
    head_node = head_node.fit(trainFeatures, trainLabels, minimumEntropy, thresholdIncrement);
    timeTaken = toc;
    fprintf('Tree Created, time taken: %fs\n', round(timeTaken, 2, "decimals"));
    fprintf('Total number of nodes: %d\n', node.setgetNodeCounter);
    % Saving model
    head_node.saveModel;
end
DrawDecisionTree(head_node, "Test");

% Predictions
disp('Making Predictions');
tic
predictions = zeros(test_size, 1);
for i = 1:test_size
    predictions(i) = head_node.predict(features(i+train_size:i+train_size, :));
end
error = 0;
for i = 1:test_size
    if predictions(i) ~= label1(i+train_size)
        error = error + 1;
    end
end
timeTaken = toc;
fprintf('Test Error: %f%%, Time taken: %fs', round(error/test_size*100, 3, 'significant'), round(timeTaken, 2, "decimals"));


