%% MyMainScript

tic;

%Take Input 
inputStruct = load('../data/boat.mat');
inputImage = inputStruct.imageOrig;
[ img_x, img_y ] = size(inputImage);

% min(RMSD) = at D0* = 86
d0 = 83;

%Display the ButterWorth Filter (2nd order ,ctuoff =83)
% [H, filteredImage] = myButterWorthFiltering(inputImage,2,d0);
% imshow(H);


% Part 
frequency_cutoff_array = [.95, 1 ,1.05];	

% for i=1:3

% 	%Normalize Image to range(0,1)
% 	normazlizedImage = inputImage/255;

% 	%Add gaussion noise with s.d = .1 and mean =0
% 	noisyImage = imnoise(normazlizedImage,'gaussian',0,0.01)*255;

% 	% Apply Filter
% 	[H, filteredImage] = myButterWorthFiltering(noisyImage,2,frequency_cutoff_array(i)*d0);
		
% 		%Calculating RMSD
% 		diffImage = filteredImage - inputImage;
% 		RMSD = sqrt(sum(sum(diffImage.^2))/(img_y*img_x));

% 		disp(RMSD);

% 		%Display Images
% 			iptsetpref('ImshowAxesVisible','on');
% 			figure('units','normalized','outerposition',[0 0 1 1])
% 			mainFig= subplot(1,3,1);
% 			imshow(mat2gray(inputImage)), colorbar;
% 			title('Input Image')
% 			subplot(1,3,2);
% 			imshow(mat2gray(noisyImage)), colorbar;
% 			title('Noisy Image')
% 			subplot(1,3,3);
% 			imshow(mat2gray(filteredImage)), colorbar;
% 			title('Filtered Image')

% 		%Save Image	
% 		name = strcat(['/home/meetshah1995/Desktop/Dropbox/Third_Year/CS663/cs-663/assignment3_FourierSegmentation/1/images/butterworth_filter_final_' num2str(frequency_cutoff_array(i)) '.']);
% 		file_name = strcat([name 'png'])
% 		imwrite(mat2gray(filteredImage),file_name);
% end
% Energy Radius Part
	F=fft2(inputImage);
	F=fftshift(F);
%   disp(abs(F(256,256)));
	Energy = sum(sum((abs(F)).^2))
	diskfilter = diskFilter(F,350);
	filteredImage = F.*diskfilter;
	FilteredImageEnergy = sum(sum(abs(filteredImage).^2))
	percentage = FilteredImageEnergy/Energy*100;
	disp(percentage);

toc;
