function output = normaliseData(data)
    % This function normalises the data. The dataset input should be :49.
    % For each row, we calculate the min and max of the 49 points, and
    % use the formula (x-min)/(max-min)
    for i = 1:size(data, 1)
        % Loop through every row
        min = 999999;
        max = -99999;
        % Find min and max
        for ii =1:size(data,2)
            if data(i,ii) < min
                min = data(i,ii);
            elseif data(i,ii) > max
                max = data(i,ii);
            end
        end
        range = max - min;
        % Update values
        for ii =1:size(data,2)
            data(i,ii) = (data(i,ii)-min)/range;
        end
    end
    output = data;
end
