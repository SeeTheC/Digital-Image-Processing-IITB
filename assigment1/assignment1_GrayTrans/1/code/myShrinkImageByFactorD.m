function outImg = myShrinkImageByFactorD(img,d)
%   Shrink the image by the factor of d
    [m,n]=size(img);    
    mOut=floor(m/d);
    nOut=floor(n/d);
    outImg=zeros(mOut,nOut);
    x=1;
    y=1;    
    for i = 1:d:m
        for j = 1:d:n
            outImg(x,y)=img(i,j);
            y=y+1;
        end
        y=1;
        x=x+1;
    end
end