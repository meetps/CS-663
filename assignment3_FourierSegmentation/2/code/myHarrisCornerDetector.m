function [] = myHarrisCornerDetector()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
%     Thresh = 50000;

    imstruct = load('../data/boat.mat');
    img=imstruct.imageOrig; % Step 0: Read Image
%     figure ;imshow(mat2gray(img));
    I=im2double(img);
%     figure; imshow(mat2gray(I));
%     dx = [-1 0 1; -1 0 1; -1 0 1]; % image derivatives
%     dy = dx';
%     Ix = imfilter(I, dx);    % Step 1: Compute the image derivatives Ix and Iy
%     Iy = imfilter(I, dy);
    [Ix Iy] = imgradientxy(I);
    
    g = fspecial('gaussian',9,2); % Step 2: Generate Gaussian filter 'g' of size 9x9 and standard deviation Sigma=2.
    Ix2 = imfilter(Ix.^2, g, 'same'); % Step 3: Smooth the squared image derivatives to obtain Ix2, Iy2 and IxIy
%     figure;imshow(mat2gray(Ix2));
    Iy2 = imfilter(Iy.^2, g, 'same');
%     figure;imshow(mat2gray(Iy2));
    IxIy = imfilter(Ix.*Iy, g, 'same');
%     figure;imshow(mat2gray(IxIy)); %Display the images obtained in different steps

    % part 1- Compute Matrix E which contains for every point the value
    [r c]=size(Ix2);
    R = zeros(r, c);
	cornerMeasure = zeros(r, c);
	E1 = zeros(r, c); % Compute matrix E
    E2 = zeros(r, c);
    
    k = 0.04;
	
    for i=1:r 
        for j=1:c
%          Ix21=sum(sum(Ix2(i-1:i+1,j-1:j+1)));
%          Iy21=sum(sum(Iy2(i-1:i+1,j-1:j+1)));
%          IxIy1= sum(sum(IxIy(i-1:i+1,j-1:j+1)));

         M=[Ix2(i,j), IxIy(i,j); IxIy(i,j), Iy2(i,j)];
         E1(i,j)=min(eig(M));
         E2(i,j)=max(eig(M));
		 
		 R(i,j)=det(M)-k*trace(M)^2; %(1) Build autocorrelation matrix for every singe pixel considering a window of size 3x3
         if(R>0)
             cornerMeasure(i,j) = 254;
         end
		 
        end
    end
    figure, imshow(mat2gray(E1)); % display result
    figure, imshow(mat2gray(E2));
    
    figure, imshow(mat2gray(cornerMeasure)); % display result

%     % Part 3 - Select for E and R the 81 most salient points
%     % Get the coordinates with maximum cornerness responses
%     % Write a function to obtain the 81 most salient points
%     numPts = 81;
%     [sortR,RIX] = sort(R(:),'descend');
%     [a, b] = ind2sub([r c],RIX);%The mapping from linear indexes to subscript equivalents for the matrix
%     figure; imshow(I, []); hold on; xlabel('Max 81 points');% Get the coordinates with maximum cornerness responses     
%     for i=1:81, 
%         plot(a(i), b(i), 'r+'); 
%     end  
% 
%     % Part 4 - Build  a  function  to  carry  out  non-maximal  suppression  for  E  and
%     % R.  Again, the 81 most salient points using a non-maximal suppression of 1111 pixels.
%     R1= ordfilt2(R,121,ones(11));% Get the coordinates with maximum cornerness responses
%     R2=(R1==R) & (R > 10);
%     [sortR2,R2IX] = sort(R2(:),'descend');
%     [a, b] = ind2sub([r c],R2IX); %The mapping from linear indexes to subscript equivalents for the matrix
%     figure; imshow(I, []); hold on; xlabel('Max 81 points'); %labeling along with X axis    
%     for i=1:81 
%         plot(a(i), b(i), 'r+'); 
%     end
    
end

