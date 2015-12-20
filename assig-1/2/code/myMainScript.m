%% MyMainScript

tic;
% Assignment 1 | Part 2

% % Linear Contrast Stretching
% 
% imagePath = '../data/barbara.png';
% myLinearContrastStretching(imagePath);
% imagePath = '../data/TEM.png';
% myLinearContrastStretching(imagePath);
% imagePath = '../data/canyon.png';
% myLinearContrastStretching(imagePath);
% 
% % Histogram Equalization
% % 
% imagePath = '../data/barbara.png';
% myHE(imagePath);
% imagePath = '../data/TEM.png';
% myHE(imagePath);
% imagePath = '../data/canyon.png';
% myHE(imagePath);
% 
% %  Adaptive Histogram Equalization
% 
% imagePath = '../data/barbara.png';
% myAHE(imagePath,90,90);
% myAHE(imagePath,10,10);
% myAHE(imagePath,190,190);
% imagePath = '../data/TEM.png';
% myAHE(imagePath,90,90);
% myAHE(imagePath,10,10);
% myAHE(imagePath,190,190);
% imagePath = '../data/canyon.png';
% myAHE(imagePath,170,170);
% myAHE(imagePath,10,10);
% myAHE(imagePath,290,290);

% Contrast Limited Adaptive Histogram Equalization

imagePath = '../data/barbara.png';
myCLAHE(imagePath,90,90,0.005);
imagePath = '../data/TEM.png';
myCLAHE(imagePath,90,90,0.005);
% imagePath = '../data/canyon.png';
% myCLAHE(imagePath,170,250,0.005);
% myCLAHE(imagePath,170,250,0.0025);

toc;
