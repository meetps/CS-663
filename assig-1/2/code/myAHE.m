%% Adaptive Histogram Equalization
as
    %Input Parameters: Input Image
    %                  Window Size, N
    %Output Parameters: Output Image
    
%%
    function[out] = functionC()
        N =2         
        input_image = imread('../data/barbara.png');
        [rows,cols] = size(input_image);
        pads = floor((N-1)/2);
        
        for i = 1:rows
            disp(i);            
            rowlow = max(1,i-pads);            
            rowhigh = min(rows,i+pads);
            for j = 1:cols
                collow = max(1,j-pads);              
                colhigh = min(cols,j+pads);               
                frame = [];
                %% we define a matrix which is properly cropped
                ki=1;
                kj=1;
                for ii = rowlow:rowhigh
                    kj = 1;
                    for jj = collow:colhigh
                        frame(ki,kj) = input_image(ii,jj);                        
                        kj = kj+1;
                    end
                    
                    ki = ki+1;
                end
                
                
                %% Histogram processing on the frame matrix
                P = frame(:); % A frame vector
                pix = input_image(i,j); % the pixel value needed
                Phist = hist(P,0:255); % getting the histogram in 256 bins
                Phist = double(Phist/length(P));
                %disp(Phist);
                len = length(Phist);
                for l = 2:len
                    Phist(l) = Phist(l) + Phist(l-1);
                end
                output_image(i,j) = Phist(pix)*255;
                
            end    
        end    
    
    output_image = uint8(output_image);
    out = output_image;
    imshow(out);
    end