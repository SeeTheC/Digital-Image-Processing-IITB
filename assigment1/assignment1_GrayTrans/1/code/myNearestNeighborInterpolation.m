%Test Matrix: a = [1,2,3;4,5,6;7,8,9]
%call: myNearestNeighborInterpolation(a)
function outImg = myNearestNeighborInterpolation( img )
%  Nearest Neighbhour (3M-2 , 2N-1) .
    mTime=3;
    nTime=2;
    mOffset=mTime-1;
    nOffset=nTime-1;
    
    [m,n]=size(img);
    newM=(mTime*m)-mOffset;
    newN=(nTime*n)-nOffset;
    
    z=zeros(newM,newN);
    for i=1:1:newM
        for j=1:1:newN
            z(i,j)=interpolateIntensity(img,i,j);
            %disp('-------------------');
        end
    end
    outImg=z;
end

%  Bilinear Interpolation by (3M-2 , 2N-1).
function intensity=interpolateIntensity(img,x,y)
    mTime=3;
    nTime=2;
    mOffset=mTime-1;
    nOffset=nTime-1;
    %fprintf('x=%d y=%d\n',x,y);    
    remX=rem((x+mOffset),mTime);
    remY=rem((y+nOffset),nTime);    
    if remX==0 && remY==0
        %means x,y is the direct sampled point. No need to pridict the
        %value.
        iX=(x+mOffset)/mTime;iY=(y+nOffset)/nTime;    
        intensity=img(iX,iY); 
        return;
    end
    % (x,y) its not the default point. So we have to calculate the
    % intensity of this x,y by Bilinear interpolation by considering it
    % neighbouring points (x1,y1),(x1,y2),(x2,y2),(x1,y1)

    if(remY==0)% means pixel lie on border of sqaure made by two points
        if(y==1)
            y1= y-remY; y2= y+(nTime-remY);                   
        else
            y1= y-nTime; y2= y;            
        end
        x1= x-remX; x2= x+(mTime-remX);
    elseif(remX==0)% means pixel lie on border of square made by two points
        if(x==1)
          x1= x-remX; x2= x+(mTime-remX);
        else
            x1= x-mTime; x2= x;
        end
        y1= y-remY; y2= y+(nTime-remY);        
    else
        x1= x-remX; x2= x+(mTime-remX);
        y1= y-remY; y2= y+(nTime-remY);            
    end
    %fprintf('remX=%d remY=%d\nx1=%d y1=%d\nx2=%d y2=%d\n',remX,remY,x1,y1,x2,y2);
    
    distWithNeighbour=[(x-x1)^2+(y-y1)^2,(x-x1)^2+(y-y2)^2,(x-x2)^2+(y-y1)^2,(x-x2)^2+(y-y1)^2];
    [minDis,index]=min(distWithNeighbour);
    
    if(index==1)
        nX=x1;nY=y1;
    elseif(index==2)
        nX=x1;nY=y2;
    elseif(index==3)
        nX=x2;nY=y1;
    else
        nX=x2;nY=y2;
    end
    
    %Here nX,nY is w.r.t Output image whose dimension is 3m-2 x 2n-1
    %There converting back to Input image dimension.
    iX=(nX+mOffset)/mTime;iY=(nY+nOffset)/nTime;    
    intensity=img(iX,iY);             
end



