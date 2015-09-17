function [ OutputImage,InputImage] = myMeanShiftSegmentation(sigma_S,sigma_I,noOfNeighbours)
% Implement segmentation and filtering using mean-shift.

    max_iter = 20;  

    InputImage = imread(strcat('../data/baboonColor.png'));
    InputImage=mat2gray(InputImage);
    filter = fspecial('gaussian', [5 5], 1);
    InputImage = imfilter(InputImage, filter, 'same');
    inputImageSize = size(InputImage);
    OutputImage = zeros(inputImageSize);

    % Produce the samples and set values
    nSamples = inputImageSize(1)*inputImageSize(2);
    samples = zeros(5, nSamples);

    for i=1:inputImageSize(1)
        for j=1:inputImageSize(2)
            samples(:, inputImageSize(2)*i-inputImageSize(2)+j) = [i; j; InputImage(i, j, 1); InputImage(i, j, 2); InputImage(i, j, 3)];
        end
    end

    iter=0;

    X = samples';
    output = X;
    while(iter<max_iter)
        [IDX, D] = knnsearch(X, X, 'k', noOfNeighbours);
        for i=1:nSamples
            weights = exp(-(D(i,:).^2)/2*(sigma_S^2)*(sigma_I^2));
            sum_weights = sum(weights);
            weights = weights';
            weights = [weights, weights, weights];
            output(i, 3:5) = sum(weights.*(X(IDX(i,:),3:5)))/sum_weights;
            
        end
        X = output;
        iter = iter+1;
        disp(iter);
    end
    
    for i=1:inputImageSize(1)
        for j=1:inputImageSize(2)
            OutputImage(:,:,1) = output(inputImageSize(2)*i-inputImageSize(2)+j,3);
            OutputImage(:,:,2) = output(inputImageSize(2)*i-inputImageSize(2)+j,4);
            OutputImage(:,:,3) = output(inputImageSize(2)*i-inputImageSize(2)+j,5);
        end
    end
    
end