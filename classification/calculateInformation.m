function output = calculateInformation(p , n)
    %CALCULATEINFORMATION Summary of this function goes here
    %   Detailed explanation goes here
    if p == 0  && n == 0
        output = 0;
    else
        a = p/(p+n);
        b = n/(p+n);
        if a == 0
            output = -b*log2(b);
        elseif b == 0
            output = -a*log2(a);
        else
            output = -a*log2(a)-b*log2(b);
        end
    end
end 

