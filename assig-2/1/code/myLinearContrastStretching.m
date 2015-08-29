function out_image = myLinearContrastStretching(a_inp)

[x , y, d] = size(mat2gray(a_inp));
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
end


