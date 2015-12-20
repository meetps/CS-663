function [] = myAHE(pathimg,windowsize_x,windowsize_y)

[inputImage, map] =imread(pathimg);
[row, col, d] = size(inputImage);

window_x = windowsize_x;
window_y = windowsize_y;

for i=1:row
    for j=1:col
        for k=1:d
            min_x = max(1,i-window_x);
            min_y = max(1,j-window_y);
            max_x = min(row,i+window_x);
            max_y = min(col,j+window_y);
            window_matrix = inputImage(min_x:max_x,min_y:max_y,k);

            if inputImage(i,j,k) == 0
                outputImage(i,j,k) =0;
            else
            transformationFunction = calcAHEVal(window_matrix);
            outputImage(i,j,k) = uint8(transformationFunction(inputImage(i,j,k)));
            end
        end
    end
end
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
imshow(inputImage, map),colorbar;
title('Original Image')
subplot(1,2,2);
imshow(outputImage, map),colorbar;
file_name = strcat(['../images/ahe_' num2str(window_x) '_' pathimg(9:length(pathimg))]);
imwrite(outputImage,file_name);
title(['Adaptive Histrogram Eq.' num2str(window_x) '.' ])
imshow(outputImage);
end

%% Adaptive Histogram Equalization
   %Input Parameters: Input Image
   %                  Window Size, N
   %Output Parameters: Output Image
%%

% function [ histeqimg, C ] = myHE(img)
%    [M, N, d]=size(img);
%    if (d==1)  
%        H=imhist(img);
%        H=H/(M*N);
%        C(1) = H(1)*255;
%        for (x=2:256)
%           C(x)= C(x-1) + (H(x)*255);
%        end
%        %perform mapping
%        for (i=1:M)
%            for (j=1:N)
%                f=double(img(i,j))+1;
%                histeqimg(i,j)=uint8(C(f));
%            end;
%        end;
%    else
%        for k=1:d
%            H=imhist(img(:,:,k));
%            H=H/(M*N);
%            C(1) = H(1)*255;
%            for (x=2:256)
%                C(x)= C(x-1) + (H(x)*255);
%            end
%            %perform mapping
%            for (i=1:M)
%                for (j=1:N)
%                    f=double(img(i,j,k))+1;
%                    histeqimg(i,j,k)=uint8(C(f));
%                end;
%            end;
%        end
%    end
% end

function C = calcAHEVal(inpMat)
   H=imhist(inpMat);
   [N, M] = size(inpMat);
   H=H/(N*M);
   C = double(zeros(1,255));
   C(1) = H(1)*255;

   for (k=2:256)
       C(k)= C(k-1) + (H(k)*255);
   end
end