function [featureLeft,labelLeft, featureRight, labelRight] = splitDataset(features, labels, attribute, threshold)
    counterLeft = 0;
    counterRight = 0;
    for i =1:size(features,1)
        if features(i, attribute) < threshold
            counterLeft = counterLeft + 1;
        else
            counterRight = counterRight + 1;
        end
    end
    featureLeft = zeros(counterLeft, 98);
    labelLeft = zeros(counterLeft, 1);
    featureRight = zeros(counterRight, 98);
    labelRight = zeros(counterRight, 1);
    counterLeft = 0;
    counterRight = 0;
    for i =1:size(features,1)
        if features(i, attribute) < threshold
            counterLeft = counterLeft + 1;
            featureLeft(counterLeft:counterLeft, :) = features(i:i, :);
            labelLeft(counterLeft:counterLeft, :) = labels(i:i, :);
        else
            counterRight = counterRight + 1;
            featureRight(counterRight:counterRight, :) = features(i:i, :);
            labelRight(counterRight:counterRight, :) = labels(i:i, :);
        end
    end
end
