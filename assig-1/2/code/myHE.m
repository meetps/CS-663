function[] = histogram_eq()
a_inp = imread('../data/barbara.png')
img=a_inp;
[M,N]=size(img);
H=imhist(img);
H=H/(M*N);
for (k=1:256)
C(k)=uint8(sum(H(1:k))*255);
end;
%perform mapping
for (i=1:M)
for (j=1:N)
f=double(img(i,j));
histeqimg(i,j)=C(f);
end;
end;
%note the above loop can be replaced by: %Computing the mapping function

%note the above loop can be replaced by:
%histeqimg=C(double(img)+1);
%this will be much faster!
% figure; % C = uint8(cumsum(H)*255);
imshow(histeqimg);