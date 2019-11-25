function outputFeatureY = featureExtractionY(inputFeatureY)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    outputFeatureY = inputFeatureY;
    % Eye Brows Left
    outputFeatureY(2) = inputFeatureY(2) - inputFeatureY(1);
    outputFeatureY(3) = inputFeatureY(3) - inputFeatureY(1);
    outputFeatureY(4) = inputFeatureY(4) - inputFeatureY(5);
    % Eye Brows Right
    outputFeatureY(7) = inputFeatureY(7) - inputFeatureY(6);
    outputFeatureY(8) = inputFeatureY(8) - inputFeatureY(7);
    outputFeatureY(9) = inputFeatureY(9) - inputFeatureY(10);
    % Mouth
    % outputFeatureY(32) = inputFeatureY(35) - inputFeatureY(32);
    % outputFeatureY(38) = inputFeatureY(38) - inputFeatureY(41);
end