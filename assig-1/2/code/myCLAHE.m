%% Adaptive Histogram Equalization
    %Input Parameters: Input Image
    %                  Window Size, N
    %Output Parameters: Output Image
%%

function [] = myCLAHE(pathimg,windowsize_x,windowsize_y,th)

[inputImage, map] = imread(pathimg);
[row, col, d] = size(inputImage);

window_x = windowsize_x;
window_y = windowsize_y;

for i=1:row
    for j=1:col
        for k=1:d
            min_x = max(1,i-window_x);
            min_y = max(1,j-window_y);
            max_x = min(row,i+window_x);
            max_y = min(col,j+window_y);
            window_matrix = inputImage(min_x:max_x,min_y:max_y,k);

            if inputImage(i,j,k) == 0
                outputImage(i,j,k) =0;
            else
            transformationFunction = calcCLAHEVal(window_matrix,th);
            % disp(transformationFunction);
            outputImage(i,j,k) = uint8(transformationFunction(inputImage(i,j,k)));
            end
        end
    end
end
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
imshow(inputImage, map), colorbar;
title('Original Image')
subplot(1,2,2);
imshow(outputImage, map), colorbar;
file_name = strcat(['../images/clahe_0.005_' num2str(window_x) '_' pathimg(9:length(pathimg))]);
imwrite(outputImage,file_name);
title(['Contrast Limited A[daptive Histrogram Eq.' num2str(window_x) 'threshold=].005' ])
imshow(outputImage);
end

function C = calcCLAHEVal(inpMat,th)
    Th = th;
    H=imhist(inpMat);
    [N, M] = size(inpMat);
    H=H/(N*M);
    for i = 1:256
        if H(i) > Th 
            H(i) = Th;
        end
    end
    contrastArea = 1 - sum(H);
    height = contrastArea / 256.00;
    H = H + floor(height);
    
    C(1) = H(1)*255;
    for (k=2:256)
        C(k)= C(k-1) + (H(k)*255);
    end
end
