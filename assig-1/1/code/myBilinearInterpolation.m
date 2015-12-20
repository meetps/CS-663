function [] = myBilinearInterpolation(input_image,zoom_row,zoom_col)

%myBilinearInterpolation -  This function generates the enlarged image using the bilinearly interpolated data from the original image.

[im , map] =imread(input_image);

[row col] = size(im); 
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

            BL=im(x1,y1);
            TL=im(x1,y2);
            BR=im(x2,y1);
            TR=im(x2,y2);
        
            R1=BR*yint+BL*(1-yint);
            R2=TR*yint+TL*(1-yint);
        
            im_zoom(i,j)=R1*xint+R2*(1-xint);
        end
    end
end
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
imshow(im, map), colorbar;
title('Original Image')
subplot(1,2,2);
imshow(im_zoom, map), colorbar;
imwrite(im_zoom,'../images/barbara_bli.png');
title('Enlarged Image | Bilinear Interpolation');
