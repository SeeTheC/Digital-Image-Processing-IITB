function [corrupted,filtered]= myPatchBasedFiltering(img,cmap,patchSize,windowSize,sigmaIntensity)
    [row,col]=size(img);
    % adding noise to image
    noise=guassainNoise(row,col,cmap);    
    out=zeros(row,col);
    corrupted=noise+img;
    
    % padding zeros outside the image. For simple masking
    pad=floor((windowSize+patchSize)/2);
    paddedCorruptedImage= [ zeros(row,pad) corrupted zeros(row,pad)];
    paddedCorruptedImage= [ zeros(pad,col+(2*pad));paddedCorruptedImage;zeros(pad,col+(2*pad))];    
    for i=1:1:row
        %weights of patch around a location
        weights=[];
        for j=1:1:col
            [out(i,j),weights]=PatchBasedFilteringVal(paddedCorruptedImage,[(i+pad) (j+pad)],windowSize,patchSize,sigmaIntensity,weights);
        end
    end   
    filtered=out;
end



%function to calculate filtered value of a location
function [filteredVal,weights]=PatchBasedFilteringVal(img,point,windowSize,patchSize,sigmaIntensity,weights)
    %x=point(1);y=point(2);    
    [x1,y1,x2,y2]=getWindowCoordinate(windowSize,patchSize,point);
    %fprintf('imgggg of the image:%d %d %d %d %d\n\n',x1,x2,y1,y2);
    imgWindow=img(x1:x2,y1:y2);
    %get kth patch
    [xp1,yp1,xp2,yp2]=getPatchCoordinate(patchSize,point);
    %fprintf('imgggg of the image:%d %d %d %d %d\n\n',xp1,xp2,yp1,yp2);
    imgPatch=img(xp1:xp2,yp1:yp2);
    if(isempty(weights))
        for i=1:windowSize
            for j=1:windowSize
                weights(i,j)=weightVal(imgWindow,imgPatch,[(i+floor(patchSize/2)) (j+floor(patchSize/2))],patchSize,sigmaIntensity);
            end
        %fprintf('%d\n',i);
        end
    else
        newWeights=weights(1:windowSize,2:windowSize);
        for i=1:windowSize
            newWeights(i,windowSize)=weightVal(imgWindow,imgPatch,[(i+floor(patchSize/2)) (windowSize+floor(patchSize/2))],patchSize,sigmaIntensity);
            %fprintf('%d\n',i);
        end
        weights=newWeights;
    end
    [rowW,colW]=size(weights);    
    pad=floor((patchSize+1)/2);
    paddedWeights= [ zeros(rowW,pad) weights zeros(rowW,pad)];
    paddedWeights= [ zeros(pad,colW+(2*pad));paddedWeights;zeros(pad,colW+(2*pad))];    
      
    sumOfWeights=sum(sum(weights));
    filteredMatrix=(paddedWeights./sumOfWeights).*imgWindow;
    %{
    [rowF,colF]=size(filteredMatrix);
    spx=2+patchS;
    epx=rowF-patchS;
    spy=2+patchS;
    epy=colF-patchS;    
    filteredMatrix=filteredMatrix(spx:epx,spy:epy);
    %}
    filteredVal=sum(sum(filteredMatrix));
end


%function to calulate weight of individual patch
function weight=weightVal(img,patchk,point,patchSize,sigmaIntensity)
    [x1,y1,x2,y2]=getPatchCoordinate(patchSize,point);
    patchj=img(x1:x2,y1:y2);
    %fprintf('patch of the image:%d %d \n\n',point(1),point(2));
    intensityDiff=patchj-patchk ;
    intensityDiffSq=intensityDiff.^2;
    norm=sum(sum(intensityDiffSq));
    jValue=gaussianMask(norm,sigmaIntensity);
    weight=jValue;
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

function gaussianMask=gaussianMask(x,sigma)    
    exponent=x./(2*sigma^2);   
    %amplitude = 1 / (sigma * sqrt(2*pi));  
    amplitude=1;
    gaussianMask = amplitude .* exp(-exponent);
end



% Return the [x1 y1 x2 y2] coordinate of window with center as centerCoordinate
function [x1,y1,x2,y2]=getWindowCoordinate(windowSize,patchSize,centerCoordinate)
    %m=imageDim(1);n=imageDim(2);
    x=centerCoordinate(1);y=centerCoordinate(2);    
    N=floor((windowSize+patchSize)/2);
    x1=x-N;
    x2=x+N;
    y1=y-N;
    y2=y+N;

   
end

function [x1,y1,x2,y2]=getPatchCoordinate(patchSize,centerCoordinate)
    %m=imageDim(1);n=imageDim(2);
    x=centerCoordinate(1);y=centerCoordinate(2);    
    N=floor((patchSize-1)/2);   
    x1=x-N;
    x2=x+N;
    y1=y-N;
    y2=y+N;
 
end
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
