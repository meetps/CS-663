function [ ] = faceRecognition(dataset)
%faceRecognition function to make eigenspace and recognize face using PCA
%Face Recognition Function 

% Getting base directory for image dataset 

% Select Folder containting the ORLD parent directory for ORLD database
% which conatins personwise folders s1 , s2 ..... s38

directoryPath = uigetdir(); 

% Getting Yale subfolders 
yaleFolders = dir([directoryPath '/yaleB*']);


tic

if(dataset == 'ORLD')
    noOfTrainingFolder = 35;
    noOfTestFolder = 35;
    noOfTrainingImages = 5;
    noOfTestImages =  5;
    width = 112;
    breadth = 92;
    k_array =  [1, 2, 3, 5, 10, 20, 30, 50, 75, 100, 125, 150, 170];
    k_len = 13;
    faces = 1:noOfTestFolder;
    IDs = kron(faces, ones([1 noOfTestImages]));

elseif(dataset == 'Yale')
    noOfTrainingFolder = length(yaleFolders);
    noOfTestFolder = length(yaleFolders);
    noOfTrainingImages = 30;
    noOfTestImages =  30;
    width = 192;
    breadth = 168;
    k_array = [1, 2, 3, 5, 10, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
    k_len = 16;
    faces = [1:13, 15:39];
    IDs = kron(faces, ones([1 noOfTestImages]));
end


% Generate columnized image matrix from dataset
X = zeros([width*breadth noOfTrainingFolder*noOfTrainingImages]);

for i = 1:noOfTrainingFolder
    for j = 1:noOfTrainingImages
        if(dataset == 'ORLD')
            imgPath = strcat([directoryPath '/s' num2str(i) '/' num2str(j) '.pgm']);
            image = imread(imgPath);
        end
        if(dataset == 'Yale')
            yaleFiles = dir([directoryPath '/' yaleFolders(i).name '/*.pgm']);
            imgPath = strcat([directoryPath '/' yaleFolders(i).name '/' yaleFiles(j).name]);
            image = imread(imgPath);
        end
        X(:,(noOfTrainingImages)*i-noOfTrainingImages+j) = image(:);
    end
end

% Mean Column Vector Calculation
mean = transpose(sum(transpose(X)))/(noOfTrainingFolder*noOfTrainingImages);
X = X - kron(mean, ones([1 noOfTrainingFolder*noOfTrainingImages]));

% Generate X'*X and find its eigenvectors
[W,D] = eig(X'*X);

% Get eigenvectors and eigenvalues of Covariance Matrix and normalize them
V = X*W;
norms = sqrt(sum(V.^2));
V = V ./ kron(norms, ones([width*breadth 1]));

% Sort eigenValues and vectors from ascending to descending
D = flipud(D);
Vs = fliplr(V);

recognitionRates = zeros(k_len);

for k_index = 1:k_len
    % Extract Highest k eigenvectors
    k = k_array(k_index);
    if(dataset == 'Yale')
        Vr = Vs(:, 4:k);
    end
    if(dataset == 'ORLD')
        Vr = Vs(:, 1:k);
    end

    coeffs = transpose(Vr)*X;

    XTest = zeros([width*breadth noOfTestFolder*noOfTestImages]);

    for i = 1:noOfTestFolder
        for j = 1:noOfTestImages
            if(dataset == 'ORLD')
                imgPath = strcat([directoryPath '/s' num2str(i) '/' num2str(j+5) '.pgm']);
                image = imread(imgPath);
            end
            if(dataset == 'Yale')
                yaleFiles = dir([directoryPath '/' yaleFolders(i).name '/*.pgm']);
                imgPath = strcat([directoryPath '/' yaleFolders(i).name '/' yaleFiles(j+30).name]);
                image = imread(imgPath);
            end
            XTest(:,noOfTestImages*i-noOfTestImages+j) = double(image(:))-mean;
        end
    end


    testCoeffs = transpose(Vr)*XTest;
    predictedID = transpose((floor((dsearchn(transpose(coeffs), transpose(testCoeffs))-1)/noOfTrainingImages))+1);

    correctIDs = 0;
    for i = 1:noOfTestFolder*noOfTestImages
        if(dataset == 'Yale')
            if(predictedID(i)>=14)
                predictedID(i) = predictedID(i)+1;
            end
        end
        if(IDs(i) == predictedID(i))
            correctIDs = correctIDs + 1;
        end
    end

    recognitionRate = 100*correctIDs/(noOfTestFolder*noOfTestImages);
    recognitionRates(k_index) = recognitionRate;
    disp('Recognition rate for k=');
    disp(k_array(k_index));
    disp(recognitionRate);
end

figure;
plot(k_array, recognitionRates);
title('Recognition Rate vs. k');
xlabel('k');
ylabel('Recognition Rate');
axis on;

% Timing
toc;