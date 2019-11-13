function [p,n] = calcPandN(labels)
    % This function takes in the labels, and returns the total number of
    % positive and negative labels.
    p = 0;
    n = 0;
    for i = 1:size(labels)
        if labels(i) == 0
            n = n + 1;
        else
            p = p + 1;
        end
    end
end
