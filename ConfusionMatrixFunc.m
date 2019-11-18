function [precision,recall] = ConfusionMatrixFunc(predictions,labelTest)
%CONFUSIONMATRIXFUNC Summary of this function goes here
%   Detailed explanation goes here

c = confusionmat(predictions, labelTest);
TP = c(1,1);
FP = c(1,2);
TN = c(2,2);
FN = c(2,1);


precision = (TP/(TP + FP))*100;
recall = (TP/(TP + FN))*100;

end

