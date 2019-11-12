function output = calculateRemainder(p1, n1, p2, n2)
il=calculateInformation(p1, n1);
ir=calculateInformation(p2, n2);
%CALCULATEREMAINDER Summary of this function goes here
%   Detailed explanation goes here
totalExamples = p1+n1+p2+n2;
informationLeft = ((p1+n1)/totalExamples)*il;
informationRight= ((p2+n2)/totalExamples)*ir;
output = informationLeft+informationRight;
end

