function [blurImg,cornerImg,corners,Ix,Iy ] = myHarrisCornerDetector(img,windowSize,blurSigma,sigma,k)
%   Corner detection
    [row,col]=size(img);
    %
    blurMask=fspecial('gaussian',[windowSize windowSize],blurSigma);
    blurImg=imfilter(img,blurMask);
    
    % taking derivative of image
    xDervMask=[-1,0,1;-2,0,2;-1,0,1];
    yDervMask=[-1,-2,-1;0,0,0;1,2,1];  
    Ix=imfilter(blurImg,xDervMask);
    Iy=imfilter(blurImg,yDervMask);
    halfWinSize=floor((windowSize-1)/2);
    paddedIx=getPaddedImg(Ix,windowSize);    
    paddedIy=getPaddedImg(Iy,windowSize);  
    corners=[];
    threshold=0.1;
    % Guassian mask for A
    W=fspecial('gaussian',[windowSize windowSize],sigma);    
    for i=4:row-4
        imgX=i+halfWinSize;
        for j=4:col-4
            imgY=j+halfWinSize;
            x1=imgX-halfWinSize;x2=imgX+halfWinSize;
            y1=imgY-halfWinSize;y2=imgY+halfWinSize;
            %fprintf('i=%d j=%d x1=%d x2=%d y1=%d y2=%d\n',i,j,x1,x2,y1,y2);
            out(i,j)=harrisCornnerDetector(paddedIx(x1:x2,y1:y2),paddedIy(x1:x2,y1:y2),W,k);
            if out(i,j)>threshold
                corners=[corners;i,j];
            end
        end
    end           
    cornerImg=out;    
end

%Corner-ness
function [val]=harrisCornnerDetector(Ix,Iy,W,K)

    % Finding second moment matrix Or Structure []
    sumIxSq= sum ( sum ( (Ix.^2).*W ) );
    sumIySq= sum ( sum ( (Iy.^2).*W ) );
    sumIxIy= sum ( sum (  Ix.*Iy.*W ) );
    % structure tensor
    A = [sumIxSq, sumIxIy; sumIxIy, sumIySq];
    corner_ness =  det(A) - K* (trace(A)^2);
    val=corner_ness;
    % corner_ness > 0 then its a corner
    
end
% Pad Extra Zeros outside the image 
function [paddedImg] = getPaddedImg(img,windowSize)    
    [row,col]=size(img);
    pad=floor((windowSize)/2);
    paddedImg= [ zeros(row,pad),img,zeros(row,pad)];
    paddedImg= [ zeros(pad,col+(2*pad));paddedImg;zeros(pad,col+(2*pad))];      
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


