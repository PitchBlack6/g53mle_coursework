function output = calculateInformation(p , n)
%CALCULATEINFORMATION Summary of this function goes here
%   Detailed explanation goes here
a = p/(p+n);
b = n/(p+n);

output = (-1*a)*log2(a)-b*log2(b); 
end 

