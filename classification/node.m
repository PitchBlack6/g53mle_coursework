classdef node
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    properties        
        % Pointer to left and right nodes, only for non leaf nodes
        leftNode
        rightNode
        % Output class, either 0 or 1, only for leaf nodes
        class
        attributeNumber
        attributeThreshold
    end
    
    methods
        % Takes in features and labels and outputs tree
        % Tree is defined by the root node, with recursive pointers to all
        % the other nodes
        function obj = fit(obj, features, labels)
            % Checks if it is a lead node
            isLeaf = 0;
            [positiveCounter, negativeCounter] = calcPandN(labels);
            information = calculateInformation(positiveCounter,negativeCounter);
            fprintf('Node entropy: %d \n', information);
            if information < 0.1
                isLeaf = 1;
                if negativeCounter > positiveCounter
                    obj.class = 0;
                else
                    obj.class = 1;
                end
            end

            % If it is not a leaf node, set values for other properties
            if isLeaf == 0
                % iterate through attributes and thresholds to find highest
                % gain
                highestGain = 0;                
                for attribute = 1:size(features, 2)
                    for threshold = 0: 0.01: 1
                        [featureLeft, labelLeft, featureRight, labelRight] = splitDataset(features, labels, attribute, threshold);
                        % calculate gain
                        [pLeft, nLeft] = calcPandN(labelLeft);
                        [pRight, nRight] =calcPandN(labelRight);
                        remainder = calculateRemainder(pLeft, nLeft, pRight, nRight);
                        gain = information - remainder;
                        % store highest gain, and the corresponding att and thresh
                        if gain>highestGain
                            highestGain = gain;
                            obj.attributeNumber = attribute;
                            obj.attributeThreshold = threshold;
                        end
                        
                    end
                end
                % split data based on that att and thresh
                fprintf('Highest Gain: %d \n', highestGain);
                [featureLeft, labelLeft, featureRight, labelRight] = splitDataset(features, labels, obj.attributeNumber, obj.attributeThreshold);
                % Left and right nodes
                obj.leftNode = node;
                obj.leftNode = obj.leftNode.fit(featureLeft, labelLeft);
                obj.rightNode = node;
                obj.rightNode = obj.rightNode.fit(featureRight, labelRight);
            end
        end
        function prediction = predict(obj, feature)
            if obj.class == 0
                prediction = 0;
            elseif obj.class == 1
                prediction = 1;
            else
                if feature(obj.attributeNumber)<obj.attributeThreshold
                    prediction = obj.leftNode.predict(feature);
                else
                    prediction = obj.rightNode.predict(feature);
                end
            end
        end
    end
end

