%% MyMainScript

tic;
%% Part 1

inputImage = double(imread('../data/barbara256.png'));
myPCADenoising1(inputImage);

%% Part 2

myPCADenoising2(inputImage);


%% Part 3

% Adding Noise to Image
[ img_x, img_y ] = size(inputImage);
noise = 0.05*max(max(inputImage))*randn([img_x img_y]);
corruptedImage = inputImage + noise;

% Optimum Parameters for Bilateral Filtering

% windowSize = 5
% SD_Intensity = 4
% SD_Space = 1.3


[ spaceGaussian outputImage ] = myBilateralFiltering(corruptedImage,1.3,4,5);

figure;%('units','normalized','outerposition',[0 0 1 1]);
subplot(1, 2, 1), imshow(mat2gray(corruptedImage));
title('Original Image');
subplot(1, 2, 2), imshow(mat2gray(outputImage));
title('Bilaterally filtered Image');

toc;
