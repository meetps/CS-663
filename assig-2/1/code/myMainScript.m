%% Assignment 2 | Image Sharpening 

tic;
%% Image Sharpening 

% Taking input from images
imgPathArray = {'../data/lionCrop.mat';'../data/superMoonCrop.mat'};
scalingArray = [1.5,1.1];
radiusArray = [1.1,0.3];
for i=1:2
	imgpath = char(imgPathArray(i));
	inputStruct = load(imgpath);
	inputImage = inputStruct.imageOrig;

	%LCS for Input Image
	linearContrastStretchedInputImage = mat2gray(myLinearContrastStretching(inputImage));

	% Sharpening
	[ sharpenedImage ] = myUnsharpMasking(inputImage, scalingArray(i), radiusArray(i));

	%LCS for Output Image
	linearContrastStretchedOutputImage = mat2gray(myLinearContrastStretching(sharpenedImage));

	% Display Images
	iptsetpref('ImshowAxesVisible','on');
	figure('units','normalized','outerposition',[0 0 1 1])
	subplot(1,2,1);
	imshow(linearContrastStretchedInputImage), colorbar;
	title('Linear Contrast Stretched Input Image')
	subplot(1,2,2);
	imshow(linearContrastStretchedOutputImage), colorbar;
	name = strcat(['../images/sharp_lcs_' imgpath(9:length(imgpath)-3)]);
	file_name = strcat([name 'png'])
	imwrite(linearContrastStretchedOutputImage,file_name);
	title('Linear Contrast Stretched Sharpened Image');
end

toc;