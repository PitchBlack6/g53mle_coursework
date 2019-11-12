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
normalisedX = normaliseData(featureX);
normalisedY = normaliseData(featureY);
features = [normalisedX normalisedY];
trainFeatures = features(1:60000, :);
trainLabels = label1(1:60000, :);
testFeatures = features(60001:82906, :);
testLabels = label1(60001:82906, :);
disp('Data Normalized');

% Create tree
disp('Creating Tree');
head_node = node;
head_node = head_node.fit(trainFeatures, trainLabels);
disp('Tree Created');

disp('Making Predictions');
predictions = zeros(22906, 1);
for i = 1:22906
    predictions(i) = head_node.predict(features(i+60000:i+60000, :));
end
error = 0;
for i = 1:22906
    if predictions(i) ~= label1(i+60000)
        error = error + 1;
    end
end
fprintf('Test Error: %f %\n', error/1000*100);
