function output = normaliseData(data)
    for i = 1:size(data)
        min = 999999;
        max = -99999;
        for ii =1:49
            if data(i,ii) < min
                min = data(i,ii);
            elseif data(i,ii) > max
                max = data(i,ii);
            end
        end
        range = max - min;
        for ii =1:49
            data(i,ii) = (data(i,ii)-min)/range;
        end
    end
    output = data;
end

