%% MyMainScript

tic;
%% Bilateral Filtering

%Loading Input Image
imgpath = '../data/barbara.mat'
inputStruct = load(imgpath);
inputImage = inputStruct.imageOrig;

sd_space_array = [1, .9, 1.1, 1, 1];	
sd_intensity_array = [1, 1, 1, .9, 1.1];	

% Filtering Image with Optimal Value
% sd_space = 1.3
% sd_intensity = 4
% windowsize = 5

% Adding gaussion noise to image 
[ img_x, img_y ] = size(inputImage);
noise = 0.05*max(max(inputImage))*randn([img_x img_y]);
corruptedImage = inputImage + noise;

windowSize =5;

[x_len,y_len] = meshgrid(-windowSize:windowSize,-windowSize:windowSize);
spaceGaussian = exp(-(x_len.^2+y_len.^2)/(2*1.3^2));

	imshow(spaceGaussian,'InitialMagnification','fit'), colorbar;
    title('Gaussion Mask');

for i=1:5

	[ spaceGaussian filteredImage ] = myBilateralFiltering(corruptedImage,sd_space_array(i)*1.3, sd_intensity_array(i)*4 ,5);

	%Calculating RMSD
	diffImage = filteredImage - inputImage;
	RMSD = sqrt(sum(sum(diffImage.^2))/(img_y*img_x));

	%Display Images
		iptsetpref('ImshowAxesVisible','on');
		figure('units','normalized','outerposition',[0 0 1 1])
		mainFig= subplot(1,3,1);
		imshow(mat2gray(inputImage)), colorbar;
		title('Input Image')
		subplot(1,3,2);
		imshow(mat2gray(corruptedImage)), colorbar;
		title('Noisy Image')
		subplot(1,3,3);
		imshow(mat2gray(filteredImage)), colorbar;
		title('Filtered Image')
		
		disp(RMSD);
	%Save Image	
		name = strcat(['../images/bilateral_filtered_final_' num2str(sd_space_array(i)) '_' num2str(sd_intensity_array(i)) '_' imgpath(9:length(imgpath)-3)]);
		file_name = strcat([name 'png'])
		imwrite(mat2gray(filteredImage),file_name);
end

toc;
    