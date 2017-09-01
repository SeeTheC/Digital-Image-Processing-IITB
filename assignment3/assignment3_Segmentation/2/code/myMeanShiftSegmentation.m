function outImg = myMeanShiftSegmentation(img,iteration,hRGB,hDistance)
    [row,col,k]=size(img);
    out=zeros(row,col,k);
    % coordinateMtx
    cMtx=coordinateMtx(row,col);    
    t=1;% gradient acent parameter    
    for itter=1:1:iteration        
        for i=1:1:row
            for j=1:1:col
                val=img(i,j,:);
                meanshift=meanShiftSeg(img,[i j],cMtx,hRGB,hDistance);
                newval=val+(t*meanshift);                
                out(i,j,:)=newval;
            end
        end
        img=out;
        %fprintf('Iteration:%d\n',itter);
    end
    outImg=out;
end

% Calculating the mean shift for the pixel
function shift=meanShiftSeg(img,point,cMtx,hBandwidth,hDistance)
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

% Returns the (x,y) coordinate in as 2 Page mtx. Where 1st page is rows 
% and 2nd is col 
function mtx=coordinateMtx(row,col)
    [r,c]=ndgrid(1:row, 1:col);
    mtx(:,:,1)=r;
    mtx(:,:,2)=c;   
end

% Finds the Gaussian mask
function gaussianMask=gaussianMask(x,sigma)    
    exponent=x./(2*sigma^2);   
    %amplitude = 1 / (sigma * sqrt(2*pi));  
    amplitude=1;
    gaussianMask = amplitude .* exp(-exponent);
end