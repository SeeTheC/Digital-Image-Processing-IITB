function outImg = myAHE2(img,windowSize)
% Adaptive Histogram Equalization: AHE
    [m,n,k]=size(img);
    z=zeros(m,n,k);    
    for row=1:1:m
        for col=1:1:n
            for layer=1:1:k
               z(row,col,layer)=getIntesity(img(:,:,layer),[row,col],windowSize);    
            end
        end
    end
    outImg=z;  
end


% Finds new enhanced intensity by using AHE algo and by NxN window size;
% Note: In NxN, N is always ODD. like 3,5,7,
% At at border the portion of window is trimmed which is going out of
% image.
function intensity=getIntesity(img,coordinate,windowSize)    
    [m,n]=size(img);
    x=coordinate(1);y=coordinate(2);
    
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
    totalPixel= (x2-x1+1)*(y2-y1+1);
    val=img(x,y);
    [count,binlocation]=imhist(img(x1:x2,y1:y2));
    noOfIntensity=length(count);
    z=val;
    % Calculating  cumulative distribution of each intensity
    cDist=0;
    for i=1:1:noOfIntensity
        ithProb=count(i)/totalPixel;
        cDist=ithProb+cDist;
        if(binlocation(i)==val)
            z=cDist*255;
            break;
        end
    end        
    intensity=z;
end