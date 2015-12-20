function [ outputImg ] = myUnsharpMasking( inputImg, scaling, radius)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    filterSize = 7;
    gaussian = fspecial('gaussian', filterSize, radius);
    
    % blurred image
    blurredImg = imfilter(inputImg, gaussian, 'conv');
    
    % unsharp masking
    unsharpMasked = inputImg - blurredImg;
    
    outputImg = inputImg + scaling*unsharpMasked;
    % imshow(outputImg);
end