function [shuffledFeature, shuffledLabel] = shuffleData(feature, label)
    [m,~] = size(feature);
    idx = randperm(m);
    shuffledFeature = feature;
    shuffledLabel = label;
    for i = 1:m
        shuffledFeature(idx(i), :) = feature(i, :);
        shuffledLabel(idx(i), :) = label(i, :);
    end
end