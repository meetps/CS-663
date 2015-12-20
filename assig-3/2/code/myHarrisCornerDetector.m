function [] = myHarrisCornerDetector()

    imstruct = load('../data/boat.mat');
    img=imstruct.imageOrig; % Step 0: Read Image
    figure, imshow(mat2gray(img)),colorbar;title('Original Image');
    I=im2double(img);
    I = I/max(max(I));
    G = fspecial('gaussian', [3 3] ,1);
    I = imfilter(I, G, 'same');
    figure, imshow(mat2gray(I)),colorbar;title('Smoothened Image after Gaussion Filter');
%     dx = [-1 0 1; -1 0 1; -1 0 1]; % image derivatives
%     dy = dx';
%     Ix = imfilter(I, dx);   
%     Iy = imfilter(I, dy);
    [Ix Iy] = imgradientxy(I);
    
    g = fspecial('gaussian', [6 6] ,2); % Step 2: Generate Gaussian filter 'g' of size 9x9 and standard deviation Sigma=2.
    Ix2 = imfilter(Ix.^2, g, 'same'); % Step 3: Smooth the squared image derivatives to obtain Ix2, Iy2 and IxIy
    figure, imshow(mat2gray(Ix2)),colorbar;title('X derivative');
    Iy2 = imfilter(Iy.^2, g, 'same');
    figure, imshow(mat2gray(Iy2)),colorbar;title('Y derivative');
    IxIy = imfilter(Ix.*Iy, g, 'same');
    figure, imshow(mat2gray(IxIy)),colorbar,title('Derivative Product Ix*Iy'); %Display the images obtained in different steps

    [r c]=size(Ix2);
    R = zeros(r, c);
	cornerMeasure = zeros(r, c);
	E1 = zeros(r, c); % Compute matrix E
    E2 = zeros(r, c);
    
    k = 0.06;
	
    for i=2:r-1 
        for j=2:c-1
         Ix21=sum(sum(Ix2(i-1:i+1,j-1:j+1)));
         Iy21=sum(sum(Iy2(i-1:i+1,j-1:j+1)));
         IxIy1= sum(sum(IxIy(i-1:i+1,j-1:j+1)));

         M=[Ix21, IxIy1; IxIy1, Iy21];
         e = eig(M);
         E1(i,j)=min(e);
         E2(i,j)=max(e);
		 
		 R(i,j) = e(1)*e(2)-k*(e(1)+e(2))^2; %(1) Build autocorrelation matrix for every singe pixel considering a window of size 3x3
         
        end
    end

    superposed = zeros(r, c);
    cornerMeasure = (R>0.5)*250;
    superposed = img+cornerMeasure;
    figure, imshow(mat2gray(E1)),colorbar;title('Eigenvalue 1'); % display result
    figure, imshow(mat2gray(E2)),colorbar;title('Eigenvalue 2');
    
    figure, imshow(mat2gray(cornerMeasure)),colorbar;title('Corner Measure'); % display result
    figure, imshow(mat2gray(superposed)),colorbar;title('Superposed');

    
%     Maximal supression
%     R1= ordfilt2(R,121,ones(11));% Get the coordinates with maximum cornerness responses
%     R2=(R1==R) & (R > 10);
%     [sortR2,R2IX] = sort(R2(:),'descend');
%     [a, b] = ind2sub([r c],R2IX); %The mapping from linear indexes to subscript equivalents for the matrix
%     title; figure, imshow(I, []); hold on; xlabel('Max 81 points'); %labeling along with X axis    
%     for i=1:81 
%         plot(a(i), b(i), 'r+'); 
%     end
    
end

