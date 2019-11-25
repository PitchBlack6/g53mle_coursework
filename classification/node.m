classdef node
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    properties        
        % Used to identify the node
        nodeID
        % Pointer to left and right nodes, only for non-leaf nodes
        kids = node.empty(2, 0)
        % Which of the 98 attributes to test, only for non-leaf nodes
        attriko;bute
        % The threshold for the attributes, only for non-leaf nodes
        threshold
        % Output class, either 0 or 1, only for leaf nodes
        class
        counterLeft
        counterRight
        
        isLeafNode
        % Used for drawing decision tree
        index
        X
        Y
        
        op
        
    end
    methods (Static)
       function out = setgetNodeCounter(data)
          persistent nodeCounter;
          if nargin
            nodeCounter = data;
          end
         out = nodeCounter;
       end 
    end
    
    methods
        function obj = node
            node.setgetNodeCounter(node.setgetNodeCounter+1);
            obj.nodeID = node.setgetNodeCounter;
            obj.isLeafNode=0;
        end
        function obj = fit(obj, features, labels, minimumEntropy, thresholdIncrement)
            % Takes in features and labels and outputs tree
            % Tree is defined by the root node, with recursive pointers to all
            % the other nodes
            % Checks if it is a lead node
            isLeaf = 0;
            [positiveCounter, negativeCounter] = calcPandN(labels);
            information = calculateInformation(positiveCounter,negativeCounter);
            fprintf('Node ID: %d, Node entropy: %f \n', obj.nodeID, round(information, 2, 'significant'));
            if information < minimumEntropy
                obj.isLeafNode = 1;
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
                for att = 1:size(features, 2)
                    for thresh = 0: thresholdIncrement: 1
                        [featureLeft, labelLeft, featureRight, labelRight, counterLeft, counterRight] = splitDataset(features, labels, att, thresh);
                        % calculate gain
                        [pLeft, nLeft] = calcPandN(labelLeft);
                        [pRight, nRight] =calcPandN(labelRight);
                        remainder = calculateRemainder(pLeft, nLeft, pRight, nRight);
                        gain = information - remainder;
                        % store highest gain, and the corresponding att and thresh
                        if gain>highestGain
                            highestGain = gain;
                            obj.attribute = att;
                            obj.threshold = thresh;
                        end
                        
                    end
                end
                % split data based on that att and thresh
                fprintf('Highest Gain: %f \n', round(highestGain, 2, 'significant'));
                [featureLeft, labelLeft, featureRight, labelRight, left, right] = splitDataset(features, labels, obj.attribute, obj.threshold);
                % Left and right nodes
                obj.counterLeft = left;
                obj.counterRight = right;
                obj.kids{1} = node;
                obj.kids{1} = obj.kids{1}.fit(featureLeft, labelLeft, minimumEntropy, thresholdIncrement);
                obj.kids{2} = node;
                obj.kids{2} = obj.kids{2}.fit(featureRight, labelRight, minimumEntropy, thresholdIncrement);
            end
        end
        function prediction = predict(obj, feature)
            if obj.isLeafNode == 1
                prediction = obj.class;
            else
                if feature(obj.attribute)<obj.threshold
                    prediction = obj.kids{1}.predict(feature);
                else
                    prediction = obj.kids{2}.predict(feature);
                end
            end
        end
        function totalNodes = getTotalNodes(obj)
            totalNodes = 1;
            if obj.isLeafNode == 0
                totalNodes = totalNodes + obj.kids{1}.getTotalNodes;
                totalNodes = totalNodes + obj.kids{2}.getTotalNodes;
            end
        end
        function saveModel(obj)
            outputModel = zeros(node.setgetNodeCounter, 7);
            outputModel = outputModel -1;
            outputModel = obj.saveModelRecur(outputModel);
            writematrix(outputModel, 'model.csv');
        end
        function outputModel = saveModelRecur(obj, inputModel)
            outputModel = inputModel;
            outputModel(obj.nodeID, 1) = obj.nodeID;
            outputModel(obj.nodeID, 7) = obj.isLeafNode;
            if obj.isLeafNode == 1
                outputModel(obj.nodeID, 6) = obj.class;        
            else
                outputModel(obj.nodeID, 2) = obj.kids{1}.nodeID;
                outputModel(obj.nodeID, 3) = obj.kids{2}.nodeID;
                outputModel(obj.nodeID, 4) = obj.attribute;
                outputModel(obj.nodeID, 5) = obj.threshold;
                outputModel = obj.kids{1}.saveModelRecur(outputModel);
                outputModel = obj.kids{2}.saveModelRecur(outputModel);
            end
        end
        function obj = loadModel(obj, model)
            obj.nodeID = 1;
            obj = obj.loadModelRecur(model);
        end
        function obj = loadModelRecur(obj, model)
            obj.attribute = model(obj.nodeID, 4);
            obj.threshold = model(obj.nodeID, 5);
            obj.class = model(obj.nodeID, 6);
            obj.isLeafNode = model(obj.nodeID, 7);
            if obj.isLeafNode ~= 1
                obj.kids{1} = node;
                obj.kids{1}.nodeID = model(obj.nodeID, 2);
                obj.kids{1} = obj.kids{1}.loadModelRecur(model);
                obj.kids{2} = node;
                obj.kids{2}.nodeID = model(obj.nodeID, 3);
                obj.kids{2} = obj.kids{2}.loadModelRecur(model);
            end
        end
    end
end
