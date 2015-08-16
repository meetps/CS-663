function [] = myShrinkImageByFactorD(inputImage, D)
%myShrinkImageByFactorD Summary of this function goes here
% <To be written sometime soon>   

[im, map] = imread(inputImage);
[rows,columns] = size(im);
disp(rows);
disp(columns);
resized_matrix = [];
    for i = 1:rows
        shrink_col = [];
        if rem(i,D) == 0 
            for j = 1:columns
                if rem(j,D) == 0
                    shrink_col = [shrink_col,im(i,j)];
                end
            end
        end
        resized_matrix = [resized_matrix;shrink_col];
    end
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
imshow(im, map), colorbar;
title('Original Image')
subplot(1,2,2);
imshow(resized_matrix, map), colorbar;
title('Shrinked Image')
end