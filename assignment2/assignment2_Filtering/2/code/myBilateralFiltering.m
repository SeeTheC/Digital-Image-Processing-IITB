function [corrupted,filtered]= myBilateralFiltering(img)
    [row,col]=size(img);
    noise=guassainNoise(row,col);    
    corrupted=noise+img;
    filtered=noise;
end

function noise= guassainNoise(row,col)    
    %adding noise to an image
    % sd is 5% of Intensity range. 5*256=12.8
    rng(0,'twister');
    mean = 0.0;
    sigma = 0.05*256;
    noise = sigma.*randn(row,col) + mean;    
    %j = imnoise(uint8(img1),'gaussian',0,sigma^2/255^2);
end

function filter=bilateralFilter(img):

end