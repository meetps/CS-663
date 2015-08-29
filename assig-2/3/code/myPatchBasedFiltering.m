function [outputImage ] = myPatchBasedFiltering(origImage, windowSize, patchSize, sd)

% windowSize = 12;
% patchSize = 4;
% sd = 1;

origImageSize = size(origImage);
% outputImage = zeros(origImageSize);

bar = waitbar(0,'Computing Filter ..');

for i = 1:origImageSize(1)
    for j = 1:origImageSize(2)
        xMin = max(i-windowSize,1);
        xMax = min(i+windowSize,origImageSize(1));
        yMin = max(j-windowSize,1);
        yMax = min(j+windowSize,origImageSize(2));
        window = origImage(xMin:xMax,yMin:yMax);

        [ windowX, windowY ] = size(window);

        basexMin = max(i-patchSize,1);
        basexMax = min(i+patchSize,origImageSize(1));
        baseyMin = max(j-patchSize,1);
        baseyMax = min(j+patchSize,origImageSize(2));
        basePatch = origImage(basexMin:basexMax,baseyMin:baseyMax);

        [ baseX , baseY ] = size(basePatch);

        weight = zeros(windowX,windowY);

        for k = 1:windowX
        	for l = 1:windowY
		        patchxMin = max(k-patchSize,1);
		        patchxMax = min(k+patchSize,windowX);
		        patchyMin = max(l-patchSize,1);
		        patchyMax = min(l+patchSize,windowY);

		        patch = window(patchxMin:patchxMax,patchyMin:patchyMax);
		        [ patchX , patchY ] = size(patch);

		        if(patchX==baseX && patchY==baseY)
                    diffPatch = basePatch - patch;                    
                else
                    patch = patch(1:min(patchX,baseX),1:min(patchY,baseY));
                    normBasePatch = basePatch(1:min(patchX,baseX),1:min(patchY,baseY));
                    diffPatch = normBasePatch - patch;
                end
% 		        [x_len,y_len] = meshgrid(-(i-1):size(patch,2)-i,-(j-1):size(patch,1)-j);
%                 spaceGaussian = exp(-(x_len.^2+y_len.^2)/(2*1^2));
                
%                 diffPatch = diffPatch.*spaceGaussian;
		        weight(k,l) = sum(sum(diffPatch.^2))/(size(diffPatch,1)*size(diffPatch,2));
        	end
        end
        
        % applying gaussian over the difference of the patches
        windowWeight = exp(-weight/(sd^2));
        windowWeight = windowWeight/(sum(sum(windowWeight)));

        % disp(window);
        % disp(['weight = ' num2str(size(windowWeight))])
        % disp(['win = ' num2str(size(window))])

        outputImage(i,j) = sum(sum(windowWeight.*window));

    end
    waitbar(i/origImageSize(1), bar);
end

% imshow(origImage);
imshow(mat2gray(outputImage));
end