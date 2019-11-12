function [p,n] = calcPandN(labels)
%CALCPANDN Summary of this function goes here
%   Detailed explanation goes here
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

