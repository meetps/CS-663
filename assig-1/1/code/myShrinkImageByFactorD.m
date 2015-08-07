function [] = myShrinkImageByFactorD()
%myShrinkImageByFactorD Summary of this function goes here
% <To be written sometime soon>   

im = imread('../data//circles_concentric.png');
[rows,columns] = size(im);
disp(rows);
disp(columns);
D = 1;
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
imshow(resized_matrix);
end
