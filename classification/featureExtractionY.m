function outputFeatureY = featureExtractionY(inputFeatureY)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    outputFeatureY = inputFeatureY;
    outputFeatureY(32) = inputFeatureY(35) - inputFeatureY(32);
    outputFeatureY(38) = inputFeatureY(38) - inputFeatureY(41);
end