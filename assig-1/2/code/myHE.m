function [ histeqimg, C ] = myHE(pathimg)
   [img, map] = imread(pathimg);
   [M, N, d]=size(img);
   if (d==1)  
       H=imhist(img);
       H=H/(M*N);
       C(1) = H(1)*255;
       for (x=2:256)
          C(x)= C(x-1) + (H(x)*255);
       end
       %perform mapping
       for (i=1:M)
           for (j=1:N)
               f=double(img(i,j))+1;
               histeqimg(i,j)=uint8(C(f));
           end;
       end;
   else
       for k=1:d
           H=imhist(img(:,:,k));
           H=H/(M*N);
           C(1) = H(1)*255;
           for (x=2:256)
               C(x)= C(x-1) + (H(x)*255);
           end
           %perform mapping
           for (i=1:M)
               for (j=1:N)
                   f=double(img(i,j,k))+1;
                   histeqimg(i,j,k)=uint8(C(f));
               end;
           end;
       end
   end
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
imshow(img, map), colorbar;
title('Original Image')
subplot(1,2,2);
imshow(histeqimg, map), colorbar;
file_name = strcat(['../images/he_' pathimg(9:length(pathimg))]);
imwrite(histeqimg,file_name);
title(['Histrogram Equalized Image']);