function [] = myPCADenoising2(im)
    
    [imSizeX, imSizeY] = size(im);

    % im1 is the corrupted image
    im1 = im + 20*randn(imSizeX, imSizeY);
    
    outputImage = double(zeros(imSizeX, imSizeY));
    outputMask = double(zeros(imSizeX, imSizeY));

    for i=1:imSizeX-6
        for j=1:imSizeY-6

            % Generate the subimage
            prinPatch = reshape(im1(i:i+6, j:j+6), 49, 1);

            xMin = max(i-15,1);
            xMax = min(i+15-6,imSizeX-6);
            yMin = max(j-15,1);
            yMax = min(j+15-6,imSizeY-6);

            patches = zeros([49 (xMax-xMin+1)*(yMax-yMin+1)]);

            for k=xMin:xMax
                for l=yMin:yMax
                    patch = reshape(im(k:k+6, l:l+6), 49, 1);
                    patches(:,(xMax-xMin+1)*(k-xMin+1)-(xMax-xMin+1)+(l-yMin+1)) = patch;
                end
            end

            patchIndices = knnsearch(transpose(patches), transpose(prinPatch), 'k', 200);
            selectedPatches = patches(:,patchIndices);
%             selectedPatches = transpose(selectedPatches);

            % Get eigenvectors
            L = selectedPatches*transpose(selectedPatches);
            [W,D] = eig(L);

            % Normalize
            norms = sqrt(sum(W.^2));
            W = W ./ kron(norms, ones([7*7 1]));

            % Get coefficients
            coeffs = transpose(W)*selectedPatches;

            % Get estimates of original coefficients
            origCoeffsTemp = transpose(sum(transpose(coeffs.^2)))/min(200, size(selectedPatches,2));
            origCoeffsEst  = max(0, origCoeffsTemp-400);

            % Modify coefficients
            denoisedCoeffs = coeffs ./ (1 + 20./ kron(origCoeffsEst, ones([1 min(200, size(selectedPatches,2))])));
            denoisedPatch = W*denoisedCoeffs(:, 1);

            outputImage(i:i+6, j:j+6) = outputImage(i:i+6, j:j+6) + reshape(denoisedPatch, 7, 7);
            outputMask(i:i+6, j:j+6) = outputMask(i:i+6, j:j+6) + 1;

        end
    end

    outputImage = outputImage./outputMask;
    
    figure;
    subplot(1, 2, 1), imshow(im1/max(max(im1)));
    subplot(1, 2, 2), imshow(outputImage/max(max(outputImage)));
end
