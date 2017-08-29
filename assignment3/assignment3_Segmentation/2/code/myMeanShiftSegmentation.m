function outImg = myMeanShiftSegmentation(img,iteration,hBandwidth,hDistance)
    [row,col,k]=size(img);
    out=zeros(row,col,k);
    % coordinateMtx
    cMtx=coordinateMtx(row,col);    
    t=1;% gradient acent parameter    
    for itter=1:1:iteration        
        for i=1:1:row
            for j=1:1:col
                val=img(i,j,:);
                meanshift=GaussianFilterVal1(img,[i j],cMtx,hBandwidth,hDistance);
                newval=val+(t*meanshift);                
                out(i,j,:)=newval;
            end
        end
        img=out;
        fprintf('Iteration:%d\n',itter);
    end
    outImg=out;
end

% Returns the (x,y) coordinate in as 2 Page mtx. Where 1st page is rows 
%and 2nd is col 
function mtx=coordinateMtx(row,col)
    [r,c]=ndgrid(1:row, 1:col);
    mtx(:,:,1)=r;
    mtx(:,:,2)=c;   
end
function shift=GaussianFilterVal1(img,point,cMtx,hBandwidth,hDistance)
    x=point(1);y=point(2);    
    ip=img(x,y,:);
    coordinate(1,1,1)=x;coordinate(1,1,2)=y;    
    
    % Intesity Kernel
    intensityDiff=bsxfun(@minus,img,ip);
    intensityDiffSq=intensityDiff.^2;    
    % [r-rx]^2+[g-gx]^2+[b-bx]^2
    intensitySum=intensityDiffSq(:,:,1)+intensityDiffSq(:,:,2)+intensityDiffSq(:,:,3);    
    % Finding G(|Ii-Ip|) exponent value         
    kernelIntesity=gaussianMask(intensitySum,hBandwidth);
    
    %Distance Kernel
    distanceDiff=bsxfun(@minus,cMtx,coordinate);
    distanceDiffSq=distanceDiff.^2;    
    % [x-xi]^2+[y-yi]^2    
    distanceSum=distanceDiffSq(:,:,1)+distanceDiffSq(:,:,2);    
    % Finding G(|Ii-Ip|) exponent value         
    kerneldistance=gaussianMask(distanceSum,hDistance);
    
    %Final Kernel
    kernel=kernelIntesity.*kerneldistance;
    
    distribution=bsxfun(@times,img,kernel);
    mean=sum(sum(distribution))/sum(sum(kernel));
    shift=mean-ip;
    
end

function shift=GaussianFilterVal(img,point,hBandwidth)
    x=point(1);y=point(2);    
    %[x1,y1,x2,y2]=getWindowCoordinate(windowSize,point,[row,col]);
    ip=img(x,y);
    %imgWindow=img(x1:x2,y1:y2);
    
    % Finding G(|Ii-Ip|) exponent value
    intensityDiff=img-ip;
    intensityDiffSq=intensityDiff.^2;
    gDistance=gaussianMask(intensityDiffSq,hBandwidth);
    gaussianWt=gDistance.*img;
    mean=sum(sum(gaussianWt))/sum(sum(gDistance));
    shift=mean-ip;        
end


% Finds the Gaussian mask
function gaussianMask=gaussianMask(x,sigma)    
    exponent=x./(2*sigma^2);   
    %amplitude = 1 / (sigma * sqrt(2*pi));  
    amplitude=1;
    gaussianMask = amplitude .* exp(-exponent);
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