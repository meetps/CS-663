function [ histeqimg, C ] = myHE(inputImage)
   [img, map] = imread(inputImage);
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
   imshow(histeqimg);