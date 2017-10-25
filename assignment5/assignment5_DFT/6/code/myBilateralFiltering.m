function [filtered,spaceMask]= myBilateralFiltering(img,windowSize,sigmaSpace,sigmaIntensity)
    [row,col]=size(img);
    out=zeros(row,col);
    % F(||P-Q||) is the Guassian distance fExponenet is the power of
    % e^-exponent
    mask=distance2DMask([windowSize windowSize]);
    fDistance=gaussianMask(mask,sigmaSpace);     
    for i=1:row
        for j=1:col
            out(i,j)=bilateralFilterVal(img,[i j],windowSize,fDistance,sigmaIntensity);
        end
    end 
    filtered=out;
    spaceMask=fDistance;
end

% point: (x,y)
function filteredVal=bilateralFilterVal(img,point,windowSize,fDistance,sigmaIntensity)
    [row,col]=size(img);
    x=point(1);y=point(2);    
    [x1,y1,x2,y2]=getWindowCoordinate(windowSize,point,[row,col]);
    ip=img(x,y);
    imgWindow=img(x1:x2,y1:y2);
    if(needToCropMask([x y],[x1,y1,x2,y2]))
        fDistance=cropMask(fDistance,[x1,y1,x2,y2],[x y]);
    end
    % Finding G(|Ii-Ip|) exponent value
    intensityDiff=imgWindow-ip;
    intensityDiffSq=intensityDiff.^2;
    gDistance=gaussianMask(intensityDiffSq,sigmaIntensity);    
    %finding F(.)*G(.)        
    
    W=fDistance.*gDistance;
    numerator=sum(sum(imgWindow.*W));
    denominator=sum(sum(W));
    Ip=numerator/denominator;
    
    %guassian
    %W=fDistance;
    %numerator=sum(sum(imgWindow.*W));
    %denominator=sum(sum(W));
    %Ip=numerator/denominator;
    
    filteredVal=Ip;        
end

% Generate IID guassain noise
function noise= guassainNoise(row,col,cmap)    
    %adding noise to an image
    % sd is 5% of Intensity range. 5*256=12.8
    rng(0,'twister');
    mean = 0.0;
    sigma = 0.05*cmap;
    noise = sigma.*randn(row,col) + mean;    
    %j = imnoise(uint8(img1),'gaussian',0,sigma^2/255^2);
end

% dim should be Odd then we will able center
function mask=distance2DMask(dim)
    % Finds the Eucledian Norm ||P-Q||^2 where p=(x1,y1) and q(x2,y2)
    row=dim(1);col=dim(2);    
    centerX=ceil(row/2);centerY=ceil(col/2);
    [r,c] = ndgrid(1:dim, 1:dim);
    % Xi-x
    xDiff=r-centerX;
    % Yi-y
    yDiff=c-centerY;
    % Taking Sq (Xi-x)^2 & (Yi-y)^2
    xDiffSq=xDiff.^2;
    yDiffSq=yDiff.^2;    
    % Eucledian Norm ||P-Q||^2 i..  ( sqrt ( (Xi-x)^2 & (Yi-y)^2 ) )^2
    norm=xDiffSq+yDiffSq;
    mask=norm;
end

% Finds the Gaussian mask
function gaussianMask=gaussianMask(x,sigma)    
    exponent=x./(2*sigma^2);   
    %amplitude = 1 / (sigma * sqrt(2*pi));  
    amplitude=1;
    gaussianMask = amplitude .* exp(-exponent);
end

% It checks whether the box is near the boundary or not
function bool=needToCropMask(centerCoordinate,boxCoordinate)
    x=centerCoordinate(1);y=centerCoordinate(2);
    x1=boxCoordinate(1);y1=boxCoordinate(2);
    x2=boxCoordinate(3);y2=boxCoordinate(4);
    
    if( x-x1 == x2-x && y-y1==y2-y )
        bool=0;% window is fitting fully
    else 
        bool=1;
    end
end


% Mask dimension should be odd for getting the simple center point
function cropped=cropMask(mask,boxCoordinate,center)
    [row,col]=size(mask);
    x=ceil(row/2);y=ceil(col/2);
    x1=boxCoordinate(1);y1=boxCoordinate(2);
    x2=boxCoordinate(3);y2=boxCoordinate(4);
    cX=center(1);cY=center(2);
    xDiff=x-cX;yDiff=y-cY;
    cropped=mask(x1+xDiff:x2+xDiff,y1+yDiff:y2+yDiff);
end

% Return the [x1 y1 x2 y2] coordinate of window with center as centerCoordinate
function [x1,y1,x2,y2]=getWindowCoordinate(windowSize,centerCoordinate,imageDim)
    m=imageDim(1);n=imageDim(2);
    x=centerCoordinate(1);y=centerCoordinate(2);    
    N=floor((windowSize-1)/2);
    if(N<0)
        N=0;
    end
    %finding windows coordinate
    % Note: In matlab indexing start from 1
    if(x-N<1) %rows
        x1=1;
    else
        x1=x-N;
    end
    if(x+N>m) %rows
        x2=m;
    else
        x2=x+N;
    end
    
    if(y-N<1) %col
        y1=1;
    else
        y1=y-N;
    end
    if(y+N>n) %col
        y2=n;
    else
        y2=y+N;
    end
   
end
