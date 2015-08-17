%% MyMainScript

tic;
% Assignment 1 | Part 2

% Linear Contrast Stretching

imagePath = '../data/barbara.png';
myLinearContrastStretching(imagePath);
imagePath = '../data/TEM.png';
myLinearContrastStretching(imagePath);
imagePath = '../data/canyon.png';
myLinearContrastStretching(imagePath);

% Histogram Equalization

imagePath = '../data/barbara.png';
myHE(imagePath);
imagePath = '../data/TEM.png';
myHE(imagePath);
imagePath = '../data/canyon.png';
myHE(imagePath);

%  Adaptive Histogram Equalization

imagePath = '../data/barbara.png';
myAHE(imagePath);
imagePath = '../data/TEM.png';
myAHE(imagePath);
imagePath = '../data/canyon.png';
myAHE(imagePath);

% Contrast Limited Adaptive Histogram Equalization

imagePath = '../data/barbara.png';
myCLAHE(imagePath);
imagePath = '../data/TEM.png';
myCLAHE(imagePath);
imagePath = '../data/canyon.png';
myCLAHE(imagePath);

toc;
