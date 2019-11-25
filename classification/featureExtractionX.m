function outputFeatureX = featureExtractionX(inputFeatureX)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    outputFeatureX = inputFeatureX;
    % Eye Brows Left
    outputFeatureX(2) = inputFeatureX(2) - inputFeatureX(1);
    outputFeatureX(3) = inputFeatureX(3) - inputFeatureX(1);
    outputFeatureX(4) = inputFeatureX(4) - inputFeatureX(1);
    outputFeatureX(5) = inputFeatureX(5) - inputFeatureX(1);
    % Eye Brows Right
    outputFeatureX(7) = inputFeatureX(7) - inputFeatureX(6);
    outputFeatureX(8) = inputFeatureX(8) - inputFeatureX(6);
    outputFeatureX(9) = inputFeatureX(9) - inputFeatureX(6);
    outputFeatureX(9) = inputFeatureX(10) - inputFeatureX(6);
end

