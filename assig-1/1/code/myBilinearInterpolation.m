function [ output_args ] = myBilinearInterpolation( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a=imread('../data/barbaraSmall1.png');      %import image"y.jpg"

[row col] = size(a);  %3 dimentional array
zoom_row=4;
zoom_col=3;
%zooming factor
zr=zoom_row*row;
zc=zoom_col*col;

for i=1:zr
    i_index = i -1;
    x=i_index/zoom_row;
    
    x1=floor(x);
    x2=ceil(x);
%      if x1==0
%          x1=1;
%      end
        x1 = x1 +1;
        x2 = x2 +1;
    xint=rem(x,1);
    for j=1:zc
        j_index = j -1;
        y=j_index/zoom_col;
        
        y1=floor(y);
        y2=ceil(y);
%         if y1==0
%             y1=1;
%         end
        yint=rem(y,1);
        y1 = y1 +1;
        y2 = y2 +1;
        
        if (x2 <= row & x1 <= row & y1 <= col & y2 <= col)

            BL=a(x1,y1);
            TL=a(x1,y2);
            BR=a(x2,y1);
            TR=a(x2,y2);
        
            R1=BR*yint+BL*(1-yint);
            R2=TR*yint+TL*(1-yint);
        
            im_zoom(i,j)=R1*xint+R2*(1-xint);
        end
    end
end
imshow(im_zoom);
disp(im_zoom(:,size(im_zoom,2)));
disp(size(im_zoom));