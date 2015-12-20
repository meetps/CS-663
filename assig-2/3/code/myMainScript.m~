tic;

%% Patch Based Filtering

%Loading Input Image
imgpath = '../data/barbara.mat'
inputStruct = load(imgpath);
inputImage = inputStruct.imageOrig;

%Filtering with optimum sd = 4 and sd*1.1 and sd*0.9
sd_array = [4.05,4.5,4.95];	

% Filtering Image with Optimal Value
windowSize = 12;
patchSize = 4;
% Adding gaussion noise to image 
[ img_x, img_y ] = size(inputImage);
noise = 0.05*max(max(inputImage))*randn([img_x img_y]);
corruptedImage = inputImage + noise;

for i=1:3
	filteredImage = myPatchBasedFiltering(corruptedImage, windowSize, patchSize, sd_array(i));
	
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
		title('Patch Filtered Image')
		
		disp(RMSD);
	%Save Image	
		name = strcat(['../images/patch_filtered_' num2str(sd_array(i)) '_' imgpath(9:length(imgpath)-3)]);
		file_name = strcat([name 'png'])
		imwrite(mat2gray(filteredImage),file_name);
end

toc;
