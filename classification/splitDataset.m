function [featureLeft,labelLeft, featureRight, labelRight] = splitDataset(features, labels, attribute, threshold)
    % This function splits the dataset based on the input attribute and threshold
    counterLeft = 0;
    counterRight = 0;
    % Calculate the size of the left and right datasets
    for i =1:size(features,1)
        if features(i, attribute) < threshold
            counterLeft = counterLeft + 1;
        else
            counterRight = counterRight + 1;
        end
    end
    % Initialise array based on size
    featureLeft = zeros(counterLeft, 98);
    labelLeft = zeros(counterLeft, 1);
    featureRight = zeros(counterRight, 98);
    labelRight = zeros(counterRight, 1);
    counterLeft = 0;
    counterRight = 0;
    for i =1:size(features,1)
        % Update values of arrays
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