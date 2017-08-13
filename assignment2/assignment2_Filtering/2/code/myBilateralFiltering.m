function [corrupted,filtered]= myBilateralFiltering(img)
    [row,col]=size(img);
    noiseImage=addGuassainNoise(img);
    
    corrupted=noiseImage;
    filtered=corrupted;
end

function noiseImage= addGuassainNoise(img)
    [row,col]=size(img);
    %adding noise to an image
    % 5% of Intensity range. 5*256=12.8
    mean = 0.0;
    variance = sqrt(0.05*256);
    noise = variance.*randn(row,col) + mean;
    corruptedImage=noise+img;
    noiseImage=corruptedImage;
end