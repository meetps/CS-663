function [ spaceGaussian outputImage ]= myBilateralFiltering(origImage,SD_Space,SD_Intensity,windowSize)

%origImage, SD_Space, SD_Intensity, windowSize

origImageStruct = load('../data/barbara.mat');
origImage = origImageStruct.imageOrig;

% SD_Space = 1;
% SD_Intensity = 1;
% windowSize = 15;

[x_len,y_len] = meshgrid(-windowSize:windowSize,-windowSize:windowSize);
spaceGaussian = exp(-(x_len.^2+y_len.^2)/(2*SD_Space^2));

origImageSize = size(origImage);
% outputImage = zeros(origImageSize);

for i = 1:origImageSize(1)
    for j = 1:origImageSize(2)
        xMin = max(i-windowSize,1);
        xMax = min(i+windowSize,origImageSize(1));
        yMin = max(j-windowSize,1);
        yMax = min(j+windowSize,origImageSize(2));
        window = origImage(xMin:xMax,yMin:yMax);
        
        intensityGaussian = exp(-(window-origImage(i,j)).^2/(2*SD_Intensity^2));
        tempMatrix = intensityGaussian.*spaceGaussian((xMin:xMax)-i+windowSize+1,(yMin:yMax)-j+windowSize+1);
        outputImage(i,j) = sum(tempMatrix(:).*window(:))/sum(tempMatrix(:));
    end
end

% imshow(origImage);
% imshow(mat2gray(outputImage));

end