classdef node
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    properties        
        % Used to identify the node
        nodeID
        % Pointer to left and right nodes, only for non-leaf nodes
        leftNode
        rightNode
        % Which of the 98 attributes to test, only for non-leaf nodes
        attributeNumber
        % The threshold for the attributes, only for non-leaf nodes
        attributeThreshold
        % Output class, either 0 or 1, only for leaf nodes
        class
        isLeafNode
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
                for attribute = 1:size(features, 2)
                    for threshold = 0: thresholdIncrement: 1
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
                fprintf('Highest Gain: %f \n', round(highestGain, 2, 'significant'));
                [featureLeft, labelLeft, featureRight, labelRight] = splitDataset(features, labels, obj.attributeNumber, obj.attributeThreshold);
                % Left and right nodes
                obj.leftNode = node;
                obj.leftNode = obj.leftNode.fit(featureLeft, labelLeft, minimumEntropy, thresholdIncrement);
                obj.rightNode = node;
                obj.rightNode = obj.rightNode.fit(featureRight, labelRight, minimumEntropy, thresholdIncrement);
            end
        end
        function prediction = predict(obj, feature)
            if obj.isLeafNode == 1
                prediction = obj.class;
            else
                if feature(obj.attributeNumber)<obj.attributeThreshold
                    prediction = obj.leftNode.predict(feature);
                else
                    prediction = obj.rightNode.predict(feature);
                end
            end
        end
        
        function totalNodes = getTotalNodes(obj)
            totalNodes = 1;
            if obj.isLeafNode == 0
                totalNodes = totalNodes + obj.leftNode.getTotalNodes;
                totalNodes = totalNodes + obj.rightNode.getTotalNodes;
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
                outputModel(obj.nodeID, 2) = obj.leftNode.nodeID;
                outputModel(obj.nodeID, 3) = obj.rightNode.nodeID;
                outputModel(obj.nodeID, 4) = obj.attributeNumber;
                outputModel(obj.nodeID, 5) = obj.attributeThreshold;
                outputModel = obj.leftNode.saveModelRecur(outputModel);
                outputModel = obj.rightNode.saveModelRecur(outputModel);
            end
        end
        function obj = loadModel(obj, model)
            obj.nodeID = 1;
            obj = obj.loadModelRecur(model);
        end
        function obj = loadModelRecur(obj, model)
            obj.attributeNumber = model(obj.nodeID, 4);
            obj.attributeThreshold = model(obj.nodeID, 5);
            obj.class = model(obj.nodeID, 6);
            obj.isLeafNode = model(obj.nodeID, 7);
            if obj.isLeafNode ~= 1
                obj.leftNode = node;
                obj.leftNode.nodeID = model(obj.nodeID, 2);
                obj.leftNode = obj.leftNode.loadModelRecur(model);
                obj.rightNode = node;
                obj.rightNode.nodeID = model(obj.nodeID, 3);
                obj.rightNode = obj.rightNode.loadModelRecur(model);
            end
        end
    end
end
