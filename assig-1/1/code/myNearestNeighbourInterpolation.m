function []= myNearestNeighbourInterpolation(inputImage) 

%myNearestNeighbourInterpolation - This Function generates the enlarged image using data from nerest neighbours and interpolating them.

[im, map] = imread(inputImage); 
[row col] = size(im); 
zoom_row=3; %zooming factor
zoom_col=2; %zooming factor
zr=zoom_row*row;
zc=zoom_col*col; 
for i = 1:zr
    x=i/zoom_row;
    mapi=round(x); %calculating the nearest pixel around ith pixel 
    if mapi==0 %since im(0,0,0) is not defined 
        mapi=1; 
    end
    for j=1:zc
        y=j/zoom_col;
        mapj=round(y);
        if mapj==0 
            mapj=1;
        end
        im_zoom(i,j)=im(mapi,mapj); %zooming to nearest neighboour 
        end 
end 
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
imshow(im, map), colorbar;
title('Original Image')
subplot(1,2,2);
imshow(im_zoom, map), colorbar;
imwrite(im_zoom,'../images/barbara_nni.png');
title('Enlarged Image | Nearest Neighbour Interpolation');
