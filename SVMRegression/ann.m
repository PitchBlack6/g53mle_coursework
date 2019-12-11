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

for n = 1:10 
    dummyFeature = trainFeatures;
    dummyFeature(n, :, :) = [];
    dummyLabel = trainLabels;
    dummyLabel(n, :, :) = [];
    
    currentTrainFeatures = reshape(dummyFeature, size(trainFeatures, 2) * 9, size(trainFeatures, 3));
    currentTrainLabels = reshape(dummyLabel, size(trainLabels, 2)*9, size(trainLabels, 3));
    
    tf = currentTrainFeatures.';
    tl = currentTrainLabels.';
    
    net = feedforwardnet(10);
    net = train(net, tf, tl);
    
    output = net(tf);
    errors = gsubtract(tl, output);
    performance = perform(net, tl, output);
    x(n) = sqrt(performance);
    disp(x(n));
    
    t_testFeatures = testFeatures.';
    t_testLabels = testLabels.';
    
    %simOut = sim(net);
    %y = net(t_testFeatures);
    %perf = perform(net, y, t_testLabels);
    %c(n) = sqrt(perf);
    %disp(c(n));
    
    % predictions = predict(net, t_testFeatures);
    
    % make predictions using ann
    % predictions = predict(net, t_testFeatures);
    
    % RMSE = sqrt(mean((predictions - t_testLabels).^2));
    
    % get RMSE by comparing predictions with testLabels
    % sumRMSE = sumRMSE + RMSE;
    % disp(RMSE);
   
end

% disp(sumRMSE/10);