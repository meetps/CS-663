function [] = reconstruction()
% Face Reconstruction using eigenspace 
% and Fourier Transform analysis of eigenvectors 

% Getting base directory for image dataset 

% Select Folder containting the ORLD parent directory for ORLD database
% which conatins personwise folders s1 , s2 ..... s38

directoryPath = uigetdir();

tic

% Index of Person to be reconstructed 
folder = 19;

% Image No of Person to be reconstructed 
imageNo = 5;

% Path to the above selected Image
reconstructImgPath = strcat([directoryPath '/s' num2str(folder) '/' num2str(imageNo) '.pgm'])


noOfFolders = 35;
noOfImages = 10;
width = 112;
breadth = 92;
k_array = [2, 10, 20, 50, 75, 100, 125, 150, 175];
k_len = 9;

% Generate columnized image matrix from dataset
X = zeros([width*breadth noOfFolders*noOfImages]);

for i = 1:noOfFolders
    for j = 1:noOfImages
    	imgPath = strcat([directoryPath '/s' num2str(i) '/' num2str(j) '.pgm']);
        image = imread(imgPath);
        X(:,noOfImages*i-noOfImages+j) = image(:);
    end
end

% Mean Column Vector Calculation
mean = transpose(sum(transpose(X)))/(noOfFolders*noOfImages);
X = X - kron(mean, ones([1 noOfFolders*noOfImages]));

% Generate X'*X and find its eigenvectors
[W,D] = eig(X'*X);

% Get eigenvectors and eigenvalues of Covariance Matrix and normalize them
V = X*W;
norms = sqrt(sum(V.^2));
V = V ./ kron(norms, ones([width*breadth 1]));

% Sort eigenValues and vectors from ascending to descending
D = flipud(D);
Vs = fliplr(V);

% Get the image
originalImage = imread(reconstructImgPath);
originalImage = double(originalImage(:));

subplot(2, 5, 10), imshow(reshape(originalImage, width, breadth)/max(originalImage));
title('Original Image');

for kInd = 1:k_len
    k = k_array(kInd);
    Vr = Vs(:, 1:k);
    coeffs = transpose(Vr)*(originalImage-mean);

    myReconstructedImage = reshape(Vr*coeffs + mean,width,breadth) ;

    subplot(2, 5, kInd), imshow(mat2gray(myReconstructedImage));
    title(['k = ' num2str(k_array(kInd))]);
end

figure;

for kEig = 1:25
    E = Vs(:,kEig);
    eigenface = reshape(E, width, breadth);
    subplot(5, 5, kEig), imshow(mat2gray(eigenface));
    title(['k = ' num2str(kEig)]);
end

figure;

for kEig = 1:25
    E = Vs(:,kEig);
    eigenface = log(1+abs(fftshift(fft2(reshape(E, width, breadth)))));
    subplot(5, 5, kEig), imshow(mat2gray(eigenface));
    title(['k = ' mat2str(kEig)]);
end

toc
end