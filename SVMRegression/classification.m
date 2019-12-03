train_size = 800;
test_size = 200;

label = load('label.csv');
label1 = label(:,1);
label2 = label(:,2);
label3 = label(:,3);
label4 = label(:,4);
label5 = label(:,5);
featureX = load('predx_for_classification.csv');
featureY = load('predy_for_classification.csv');
disp('Data Loaded');

featureX = normaliseData(featureX);
featureY = normaliseData(featureY);
disp('Data Normalized');

features = [featureX featureY];

% Shuffle data
[features, label1] = shuffleData(features, label1);
disp('Data Shuffled');

% Train test split
trainFeatures = features(1:train_size, :);
trainLabels = label1(1:train_size, :);
testFeatures = features(train_size+1:train_size+test_size, :);
testLabels = label1(train_size+1:train_size+test_size, :);
disp('Data Split');

% SVM model
md1 = fitcsvm(trainFeatures, trainLabels, 'KernelFunction', 'linear', 'BoxConstraint', 1);
disp('Model trained');

% display scatter
disp('display scatter');
sv = md1.SupportVectors;
figure;
gscatter(trainFeatures,trainLabels);
hold on
plot(sv,'ko','MarkerSize',10);
legend('Yes','No','Support Vector');
hold off


