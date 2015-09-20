function [] = myMeanShiftSegmentation_tuning()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    sigma_S = [4,6,8,12,16];
    sigma_I = [6,8,12,16];
    noOfNeighbours = 25;
    max_iter = [10,15,20]
    for i = 1:5
        for j = 1:4
            for k = 1:3
                [ OutputImage,InputImage] = myMeanShiftSegmentation( max_iter(k),sigma_S(i),sigma_I(j),noOfNeighbours);
            end
        end
    end
end

