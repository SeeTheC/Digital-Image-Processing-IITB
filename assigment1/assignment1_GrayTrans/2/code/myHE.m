function outImg = myHE(img )
% Equailize the histrogram of the image
    [m,n,k]=size(img);
    z=zeros(m,n,k);
    %fetch all new intensity mapping for avoiding recalculation
    if(k==1) %gray image                    
        grayIntensity=getEqualizeHistogram(img); 
    elseif (k==3) % image is RGB
        redIntensity=getEqualizeHistogram(img(:,:,1)); 
        greenIntensity=getEqualizeHistogram(img(:,:,2));    
        blueIntensity=getEqualizeHistogram(img(:,:,3));         
    end
    
    for row=1:1:m
        for col=1:1:n
            if(k==1) %gray image                
                z(row,col)=grayIntensity(img(row,col)+1);                               
            elseif(k==3) % color image                
                z(row,col,1)=redIntensity(img(row,col,1)+1);
                z(row,col,2)=greenIntensity(img(row,col,2)+1);
                z(row,col,3)=blueIntensity(img(row,col,3)+1);
            end            
        end
    end
    outImg=z;   
end

function intensities = getEqualizeHistogram(img )
    L=256;
    [m,n,k]=size(img);    
    [count,binlocation]=imhist(img);
    totalPixel=m*n;
    cumulativeDistribution=zeros(1,L);
    
    % Calculating  cumulative distribution of each intensity
    cumulativeDistribution(1)=count(1)/totalPixel;
    for i=2:1:L
        ithProb=count(i)/totalPixel;
        cumulativeDistribution(i)=ithProb+cumulativeDistribution(i-1);
    end        
    intensities=cumulativeDistribution*(L-1);
end

