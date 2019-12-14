function [trainFeaturesSplit, trainLabelsSplit] = splitDataset(trainFeatures, trainLabels)
    data_split_size = size(trainFeatures, 1) / 10;
    trainFeaturesSplit = zeros(10, data_split_size, 98);
    trainLabelsSplit = zeros(10, data_split_size);
    for n = 1 : 10
        to_add_start = (n-1) * data_split_size + 1;
        to_add_end = n * data_split_size;
        trainFeaturesSplit(n, :, :) = trainFeatures(to_add_start:to_add_end, :);
        % disp(size(trainFeatures(to_add_start:to_add_end, :)))
        trainLabelsSplit(n, :) = trainLabels(to_add_start:to_add_end, :);
    end
end

