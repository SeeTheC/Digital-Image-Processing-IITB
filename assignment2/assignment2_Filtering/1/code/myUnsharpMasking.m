function outImg = myUnsharpMasking( img,hsize,sigma,scalingFactor)
    %fprintf('row=%d',col);
    Gaussian_filt=fspecial('gaussian',hsize,sigma);
    Gaussian_blur=imfilter(img,Gaussian_filt);
    %to calculate the unsharp mask
    unsharp=img-Gaussian_blur;
    unsharpmask=img+scalingFactor.*unsharp;
    outImg=unsharpmask;
end
