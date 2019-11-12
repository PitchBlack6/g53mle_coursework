classdef node
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Name of the attribute tested
        attributeName
        % Pointer to left and right nodes, only for non leaf nodes
        leftNode
        rightNode
        % Output class, either 0 or 1, only for leaf nodes
        class
        attributeNumber
        attributeThreshold
    end
    
    methods
        function obj = node()
            %NODE Construct an instance of this class
        end
        
        
        
        function fit(obj, features, label1)
            %METHOD1 Summary of this method goes here
            % Checks if it is a lead node
            isLeaf = 0;
            [positiveCounter, negativeCounter] = calcPandN(label1);
            if negativeCounter == 0
                obj.class = 0;
                isLeaf = 1;
            elseif positiveCounter == 0
                obj.class = 1;
                isLeaf = 1;
            end
            disp(positiveCounter);
            disp(negativeCounter);
            % Not a leaf node, set values for other properties
            if isLeaf == 0
                % iterate through attributes and thresholds
                highestGain = 0;
                for i = 1:size(features)
                    for ii = 1:size(features(i))
                        
                % calculate gain
                % store highest gain, and the corresponding att and thresh
                
                % split data based on that att and thresh
                % create left and right node
                % call left.fit and right.fit  
                    end
                end
            end
        end 
    end
end

