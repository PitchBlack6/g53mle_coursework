function [pValue] = comparisonFunc(regError,ANNerror)
%COMPARISONFUNC Summary of this function goes here
%   Detailed explanation goes here

[h, p, ci, stats] = ttest2(regError,ANNerror);

pValue = p;

end

