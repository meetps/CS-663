function []= N() 
a=imread('../data/barbaraSmall.png'); %import image"y.jpg" 
[row col] = size(a); %3 dimentional array
zoom_row=3; %zooming factor
zoom_col=2; %zooming factor
zr=zoom_row*row;
zc=zoom_col*col; 
for i = 1:zr
    x=i/zoom_row;
    mapi=round(x); %calculating the nearest pixel around ith pixel 
    if mapi==0 %since a(0,0,0) is not defined 
        mapi=1; 
    end
    for j=1:zc
        y=j/zoom_col;
        mapj=round(y);
        if mapj==0 
            mapj=1;
        end
        im_zoom(i,j)=a(mapi,mapj); %zooming to nearest neighboour 
        end 
end 
imshow(im_zoom);
disp(size(im_zoom));
