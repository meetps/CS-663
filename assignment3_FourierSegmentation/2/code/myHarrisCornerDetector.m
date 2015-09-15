function [] =  myHarrisCornerDetector()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    imgstruct = load('../data/boat.mat');
    I = imgstruct.imageOrig;

    [numOfRows, numOfColumns] = size(I);
    
    k = 0.01;
    Threshold = 50000;
    sigma = 1;
    halfwid = sigma * 3;

    [xx, yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);

    Gxy = exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

    Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
    Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));


    Ix = conv2(Gx, I);
    Iy = conv2(Gy, I);

    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;

    Sx2 = conv2(Gxy, Ix2);
    Sy2 = conv2(Gxy, Iy2);
    Sxy = conv2(Gxy, Ixy);

    im = zeros(numOfRows, numOfColumns);
    for x=1:numOfRows,
        for y=1:numOfColumns,
            H = [Sx2(x, y) Sxy(x, y); Sxy(x, y) Sy2(x, y)];
            R = det(H) - k*(trace(H)^2);

            if (R > Threshold)
              im(x, y) = R; 
            end
        end
    end

%     % Compute nonmax suppression
%     output = im > imdilate(im, [1 0 1; 1 0 1; 1 1 1]);

    output = im;
    figure, imshow(mat2gray(I));
    figure, imshow(mat2gray(output))
    figure, imshow(Ix);
    figure, imshow(Iy);
end

