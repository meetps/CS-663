% MyMainScript

tic;
% Assignment 1 | Part 1

% Image Resizing | Undersampling

imagePath = '../data/circles_concentric.png';
myShrinkImageByFactorD(imagePath,2);
myShrinkImageByFactorD(imagePath,3);

% Image Enlargement | Bilinear Interpolation

imagePath = '../data/barbaraSmall.png';
myBilinearInterpolation(imagePath,3,2);

% Image Enlargement | NearestNeighbour Interpolation

imagePath = '../data/barbaraSmall.png';
myNearestNeighbourInterpolation(imagePath)

toc;
