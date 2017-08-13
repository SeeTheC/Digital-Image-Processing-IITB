function outImg = myUnsharpMasking( img )
    [row,col]=size(img);
    %fprintf('row=%d',col);
    Gaussian_filt=fspecial('gaussian',[100,100],1.6);
    Gaussian_blur=imfilter(img,Gaussian_filt);
    unsharp=zeros(row,col)
    %to calculate the unsharp mask
    for i=1:1:row
       for j=1:1:col
            unsharp(i,j)=img(i,j)-Gaussian_blur(i,j);
        end
    end
    unsharpmask=zeros(row,col)
    for i=1:1:row
       for j=1:1:col
             unsharpmask(i,j)=img(i,j)+unsharp(i,j);
        end
    end
    outImg=unsharpmask;
end