function diskKernel = diskFilter(inputImage,Radius)

[x y] = size(inputImage);
diskKernel = zeros(size(inputImage));
 
for i=1:x
    for j=1:y
        value = sqrt(((i-x/2)^2 + (j-y/2)^(2)));
        if(value>Radius)
            diskKernel(i,j) = 0;
        else
            diskKernel(i,j) = 1;
        end
    end
end

