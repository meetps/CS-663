tfunction [] = myLinearContrastStretching(imgpath)

[a_inp , map]= imread(imgpath);
[x , y, d] = size(a_inp);
if d==1
    intensity_max = max(max(a_inp));
	intensity_min = min(min(a_inp));
    out_image = (a_inp-intensity_min)*(255/(intensity_max- intensity_min)); 
else	
	for i=1:d
	    intensity_max = max(max(a_inp(:,:,i)));
		intensity_min = min(min(a_inp(:,:,i)));
	    out_image(:,:,i) = (a_inp(:,:,i)-intensity_min)*(255/(intensity_max- intensity_min)); 
	end
end
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
imshow(a_inp, map), colorbar;
title('Original Image')
subplot(1,2,2);
imshow(out_image, map), colorbar;
file_name = strcat(['../images/lcs_' imgpath(9:length(imgpath))]);
imwrite(out_image,file_name);
title(['Linear Contrast Stretched Image']);
end


