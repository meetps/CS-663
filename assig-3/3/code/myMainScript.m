%% MyMainScript

tic;
%% Segmentation using Mean Shift

% Segmenting Image with Optimal Value
% max_iter = 5
% sigma_I = 48
% sigma_S = 16
% noOfNeighbours = 200

noOfNeighbours_array = [100,200,300];

for i=1:3

	segmentedImage = myMeanShiftSegmentation(5,16,48,noOfNeighbours_array(i));

	%Display Images
		iptsetpref('ImshowAxesVisible','on');
		figure('units','normalized','outerposition',[0 0 1 1])
		mainFig= subplot(1,2,1);
		imshow(mat2gray(inputImage)), colorbar;
		title('Input Image')
		subplot(1,2,2);
		imshow(mat2gray(segmentedImage)), colorbar;
		title('Segmented Image')
	
	%Save Image	
		name = strcat(['../images/segmented_final_5_16_48_' num2str(noOfNeighbours_array(i)) '.']);
		file_name = strcat([name 'png'])
		imwrite(mat2gray(segmentedImage),file_name);
end

toc;
    