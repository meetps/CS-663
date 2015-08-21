function [ sharpImage ] = myUnsharpMasking( imgPath, scaling, radius)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    imgStruct = load(imgPath);
    inputImg = imgStruct.imageOrig;
    
    filterSize = 3;
    gaussian = fspecial('gaussian', filterSize, radius);
    
    % blurred image
    blurredImg = imfilter(inputImg, gaussian, 'conv');
    
    % unsharp masking
    unsharpMasked = inputImg - blurredImg;
    
    outputImg = inputImg + scaling*unsharpMasked;
    imshow(outputImg);

end