%% MyMainScript

tic;

%Take Input 
inputStruct = load('../data/boat.mat');
inputImage = inputStruct.imageOrig;
[ img_x, img_y ] = size(inputImage);

% min(RMSD) = at D0* = 84
d0 = 84;

% Display the ButterWorth Filter (2nd order ,ctuoff =83)
[H, filteredImage] = myButterWorthFiltering(inputImage,2,d0);
imshow(H),colorbar;title('ButterWorth Filter in Frequency Domain')


%% ButterWorth Filter Part 
frequency_cutoff_array = [.95, 1 ,1.05];	

for i=1:3

	%Normalize Image to range(0,1)
	normazlizedImage = inputImage/255;

	%Add gaussion noise with s.d = .1 and mean =0
	noisyImage = imnoise(normazlizedImage,'gaussian',0,0.01)*255;

	% Apply Filter
	[H, filteredImage] = myButterWorthFiltering(noisyImage,2,frequency_cutoff_array(i)*d0);
		
		%Calculating RMSD
		diffImage = filteredImage - inputImage;
		RMSD = sqrt(sum(sum(diffImage.^2))/(img_y*img_x));

		disp(['RMSD =' num2str(RMSD)]);

		%Display Images
			iptsetpref('ImshowAxesVisible','on');
			figure('units','normalized','outerposition',[0 0 1 1])
			mainFig= subplot(1,3,1);
			imshow(mat2gray(inputImage)), colorbar;
			title('Input Image')
			subplot(1,3,2);
			imshow(mat2gray(noisyImage)), colorbar;
			title('Noisy Image')
			subplot(1,3,3);
			imshow(mat2gray(filteredImage)), colorbar;
			title(['Filtered Image for D0*' num2str(frequency_cutoff_array(i))])

		%Save Image	
		name = strcat(['../images/butterworth_filter_final_' num2str(frequency_cutoff_array(i)) '.']);
		file_name = strcat([name 'png'])
		imwrite(mat2gray(filteredImage),file_name);
end

%% Energy Radius Part

% The Following Table encapsulates the enrgy percent vs Radii data
    %  93.59 - 4
    %  90.69 - 2.225
    %  90.53 - 1.4
    %  97.13 - 15
    %  99.026 - 60

nearest_percentage_array = [88,91,94,97,99];
radius_array = [1.422,2.225,4,15,60];
RMSD_array = [0,0,0,0,0];
percentage_array = [0,0,0,0,0];

for i=1:5
	
	F=fft2(inputImage);
	F=fftshift(F);
	
	%Calculating the Energy of Fourier Transform
	Energy = sum(sum((abs(F)).^2));
	
	% Deduce Filter for image
	diskfilter = diskFilter(F,radius_array(i));
	filteredImage = F.*diskfilter;
	
	%Calculate Percentage Energy in disked image
	FilteredImageEnergy = sum(sum(abs(filteredImage).^2));
	percentage = FilteredImageEnergy/Energy*100;
	percentage_array(i) = percentage;
	disp(['Percentage = ' num2str(percentage)]);


	% Applying the Filter to the  Orig Image
	inverseImage = ifft2(filteredImage);
	outputImage=sqrt(real(inverseImage).^2+imag(inverseImage).^2);

	%Display Images
			iptsetpref('ImshowAxesVisible','on');
			figure('units','normalized','outerposition',[0 0 1 1])
			mainFig= subplot(1,2,1);
			imshow(mat2gray(inputImage)), colorbar;
			title('Original Image')
			subplot(1,2,2);
			imshow(mat2gray(outputImage)), colorbar;
			title(['Image with filter of radius = ' num2str(radius_array(i))]);
	%Save Image	
		name = strcat(['../images/energy_analysis_final_' num2str(nearest_percentage_array(i)) '.']);
		file_name = strcat([name 'png'])
		imwrite(mat2gray(outputImage),file_name);

	%Calculating RMSD between Orig Image and Filtered Image
	diffImage = outputImage - inputImage;
	RMSD = sqrt(sum(sum(diffImage.^2))/(img_y*img_x));
	RMSD_array(i) = RMSD;
	disp(['RMSD =' num2str(RMSD)]);
end
toc;
