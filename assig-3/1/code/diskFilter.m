function diskFilter = diskFilter(inputImage,Radius)

[x y] = size(inputImage);
diskFilter = zeros(size(inputImage));
 
for i=1:x
    for j=1:y
        value = sqrt((i^2 + j^(2)));
        if(value>Radius)
            diskFilter(i,j) = 0;
        else
            diskFilter(i,j) = 1;
        end
    end
end

