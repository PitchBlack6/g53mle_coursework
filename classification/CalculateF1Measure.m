function [measure] = CalculateF1Measure(precision,recall)
%CALCULATEF1MEASURE Summary of this function goes here
%   Detailed explanation goes here

measure = (2*recall*precision)/(recall+precision);

end

