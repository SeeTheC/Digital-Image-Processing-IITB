function [blurImg,cornerImg,corners,filterCorner,eigenVal1,eigenVal2,Ix,Iy ] = myHarrisCornerDetector(img,windowSize,blurSigma,sigma,k)
%   Corner detection
    [row,col]=size(img);
    %
    blurMask=fspecial('gaussian',[windowSize windowSize],blurSigma);
    blurImg=imfilter(img,blurMask);
    
    % taking derivative of image
    xDervMask=[0,0,0;-1,0,1;0,0,0];
    yDervMask=xDervMask';  
    Ix=	imfilter(blurImg,xDervMask,'conv');
    Iy=imfilter(blurImg,yDervMask,'conv');
    
    halfWinSize=floor((windowSize-1)/2);
    paddedIx=getPaddedImg(Ix,windowSize);    
    paddedIy=getPaddedImg(Iy,windowSize);  
    corners=[];
    filterCorner=[];
    minThreshold=0.01;
    
    % Guassian mask for A
    %W=fspecial('gaussian',[windowSize windowSize],sigma);  
    mask=distance2DMask([windowSize windowSize]);
    W=gaussianMask(mask,sigma);
    out=zeros(row,col);
    eigenVal1=zeros(row,col);
    eigenVal2=zeros(row,col);    
    for i=4:row-4
        imgX=i+halfWinSize;
        for j=4:col-4
            imgY=j+halfWinSize;
            x1=imgX-halfWinSize;x2=imgX+halfWinSize;
            y1=imgY-halfWinSize;y2=imgY+halfWinSize;
            %fprintf('i=%d j=%d x1=%d x2=%d y1=%d y2=%d\n',i,j,x1,x2,y1,y2);
            [val,lamda1,lamda2]=harrisCornnerDetector(paddedIx(x1:x2,y1:y2),paddedIy(x1:x2,y1:y2),W,k);
            eigenVal1(i,j)=lamda1;
            eigenVal2(i,j)=lamda2;
            if val>minThreshold
                out(i,j)=val;
                corners=[corners;j,i];
                filterCorner=filterNearByCorner([i,j],filterCorner,out,windowSize);
            end
        end
    end           
    cornerImg=out;    
end

%Corner-ness and Eigen Valus of Structure Tensor Matrix
function [val,lamda1,lamda2]=harrisCornnerDetector(Ix,Iy,W,K)

    % Finding second moment matrix Or Structure []
    sumIxSq= sum ( sum ( (Ix.^2).*W ) );
    sumIySq= sum ( sum ( (Iy.^2).*W ) );
    sumIxIy= sum ( sum (  Ix.*Iy.*W ) );
    % structure tensor
    A = [sumIxSq, sumIxIy; sumIxIy, sumIySq];
    corner_ness =  det(A) - K* (trace(A)^2);
    % corner_ness > 0 then its a corner
    val=corner_ness;
    
    % Finding Eigen values of the Tensor Matrix
    [V,D]=eig(A);
    lamda1=D(1,1);lamda2=D(2,2);
end


% This will filter the nearby corner i.e within the thershold distance it
% will take the high intensity pixel within the nearby filterNearByCorner
function filterCorner=filterNearByCorner(p,corners,img,thersholdDist)
    x=p(1);y=p(2);
    [row,col]=size(corners);
    maxInt=img(x,y);
    filterCorner=corners;    
    toInsert=1;
    for i=1:row
        x1=filterCorner(i,2);y1=filterCorner(i,1);
        int=img(x1,y1);
        dist=sqrt( (x-x1)^2 + (y-y1)^2 );
        if(dist<thersholdDist)
            toInsert=0;    
            if(int<maxInt)
               filterCorner(i,:)=[y,x];               
               break;
            end
        else
            if(x-x1>thersholdDist)
                break;
            end
        end
    end
    if (toInsert)
        filterCorner=[y,x;filterCorner];
    end
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

% Pad Extra Zeros outside the image 
function [paddedImg] = getPaddedImg(img,windowSize)    
    [row,col]=size(img);
    pad=floor((windowSize)/2);
    paddedImg= [ zeros(row,pad),img,zeros(row,pad)];
    paddedImg= [ zeros(pad,col+(2*pad));paddedImg;zeros(pad,col+(2*pad))];      
end
