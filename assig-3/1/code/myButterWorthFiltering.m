function [H, g] = myButterWorthFiltering(inputImage,order,cutoff)
% Usage [g]=myButterWorthFiltering(order,cutoff);

% inputStruct = load('../data/boat.mat');
% f = inputStruct.imageOrig;

F=fft2(inputImage);
F=fftshift(F);
[umax vmax]=size(F);

for u=1:umax
	for v=1:vmax
		H(u,v)=1/(1+(sqrt(2)-1)*(sqrt(((umax/2-(u-1)).^2+(vmax/2-(v-1)).^2))/cutoff).^(2*order));
	end;
end;

G=H.*F;
G=ifft2(G);
g=sqrt(real(G).^2+imag(G).^2);

end

