function [ANNerror] = artificialNeuralNetwork(trainFeatures,trainLabels);
%ARTIFICIALNEURALNETWORK Summary of this function goes here
%   Detailed explanation goes here

% initialize neural network with 10 hidden neurons
net = feedforwardnet(10);
net = train(net, trainFeatures, trainLabels);
    
output = net(trainFeatures);
% errors = gsubtract(trainLabels, output);
performance = perform(net, trainLabels, output);
ANNerror = sqrt(performance);
disp(ANNerror);

end

