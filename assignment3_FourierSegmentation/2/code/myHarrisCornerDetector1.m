function [] =  myHarrisCornerDetector()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    imgstruct = load('../data/boat.mat');
    Img = mat2gray(imgstruct.imageOrig);
    if(size(Img,3)==3)
        I = rgb2gray(I);
    end
    I = imadjust(Img, [min(min(Img))/255.0, max(max(Img))/255.0], [0,1]);
    imshow(mat2gray(I));
%     I = imread('../data/corner.jpg');
%     I = rgb2gray(I);
    [M, N] = size(I);
    
    % tuning parameters
    k = 0.04;
    %Threshold = 50000;
    sigma = 1;
    halfwid = sigma * 3;

    [xx, yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);

    Gxy = exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

%     Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
%     Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
% 
% 
%     Ix = conv2(Gx, I);
%     Iy = conv2(Gy, I);

    I = imfilter(I, Gxy, 'same', 'conv');
    
    [Ix, Iy] = imgradientxy(I);
    
    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;

%     Sx2 = conv2(Gxy, Ix2);
%     Sy2 = conv2(Gxy, Iy2);
%     Sxy = conv2(Gxy, Ixy);

    im = zeros(M, N);
    for x=1:M,
        for y=1:N,
            H = [Ix2(x, y) Ixy(x, y); Ixy(x, y) Iy2(x, y)];
            R = det(H) - k*(trace(H)^2);
            E = eig(H);
            eigen1(x,y) = E(1);
            eigen2(x,y) = E(2);
            
            %if (R > Threshold)
              im(x, y) = R; 
            %end
        end
    end

%     % Compute nonmax suppression
%     output = im > imdilate(im, [1 0 1; 1 0 1; 1 1 1]);

    output = im;
    figure, imshow(mat2gray(Img));
    figure, imshow(mat2gray(output))
    figure, imshow(Ix);
    figure, imshow(Iy);
end

