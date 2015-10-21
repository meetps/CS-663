function [] = myPCADenoising1()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    im = double(imread('../data/barbara256.png'));
    [imSizeX, imSizeY] = size(im);

    % im1 is the corrupted image
    im1 = im + 20*randn(imSizeX, imSizeY);

    P = zeros([49 (imSizeX-6)*(imSizeY-6)]);

    for i=1:imSizeX-6
        for j=1:imSizeY-6

            % Generate the subimage
            patch = im1(i:i+6, j:j+6);
            P(:, (imSizeY-6)*i-(imSizeY-6)+j) = patch(:);

        end
    end

    % Get eigenvectors
    L = P*transpose(P);
    [W,D] = eig(L);

    % Normalize
    norms = sqrt(sum(W.^2));
    W = W ./ kron(norms, ones([7*7 1]));

    % Get coefficients
    coeffs = transpose(W)*P;

    % Get estimates of original coefficients
    origCoeffsTemp = transpose(sum(transpose(coeffs.^2)))/((imSizeX-6)*(imSizeY-6));
    origCoeffsEst  = max(0, origCoeffsTemp-400);

    % Modify coefficients
    denoisedCoeffs = coeffs ./ (1 + 20./ kron(origCoeffsEst, ones([1 62500])));
    denoisedPatches = W*denoisedCoeffs;

    % Reconstruct image
    outputImage = double(zeros(imSizeX, imSizeY));
    outputMask = double(zeros(imSizeX, imSizeY));

    for i=1:imSizeX-6
        for j=1:imSizeY-6

            outputImage(i:i+6, j:j+6) = outputImage(i:i+6, j:j+6) + reshape(denoisedPatches(:, (imSizeY-6)*i-(imSizeY-6)+j), 7, 7);
            outputMask(i:i+6, j:j+6) = outputMask(i:i+6, j:j+6) + 1;

        end
    end

    outputImage = outputImage./outputMask;
    figure;
    subplot(1, 2, 1), imshow(im1/max(max(im1)));
    subplot(1, 2, 2), imshow(outputImage/max(max(outputImage)));
end

