function [outImg,intensities]= myLinearContrastStretching(img,thersholdPoint1,thersholdPoint2)   
    [m,n,k]=size(img);
    z=zeros(m,n,k);
    %fetch all new intensity mapping for avoiding recalculation
    intensities=getStretchedIntensity(thersholdPoint1,thersholdPoint2);  
    for row=1:1:m
        for col=1:1:n
            for layer=1:1:k
                val=img(row,col,layer);
                z(row,col,layer)=intensities(val+1);                
            end
        end
    end
    outImg=z;   
end

% Range of input intensity is between 0 to 255 
% Range of output intensity is between 0 to 255 
function intensities= getStretchedIntensity(thersholdPoint1,thersholdPoint2)    
    inputIntensity=256;%no. of intensities
    outputIntensity=256;
    z= zeros(1,256);
    x1=0;y1=0;
    r1=thersholdPoint1(1);s1=thersholdPoint1(2);
    r2=thersholdPoint2(1);s2=thersholdPoint2(2);
    %Note: r1<=r2 and s1<=s2 for Monotonicity and contrast stretching
    x2=inputIntensity-1;y2=outputIntensity-1;
    
    % Equation of line passing through two points (x1,y1) and (x2,y2)
    % y-y1 = ((y2-y1)/(x2-x1)) (x-x1)
    % slope = (y2-y1)/(x2-x1)
    % y = slope*x - slope*x1 + y1
    slope1=(s1-y1)/(r1-x1);
    slope2=(s2-s1)/(r2-r1);
    slope3=(y2-s2)/(x2-r2);    
    for i=0:1:inputIntensity-1
       if(i<=r1)
           y=(slope1*i) - (slope1*x1) + y1;
       elseif(i>r1 && i<= r2)
           y=(slope2*i) - (slope2*r1) + s1;
       elseif(i>r2)
           y=(slope3*i) - (slope3*r2) + s2;
       end
       z(i+1)=y;
    end
    intensities=z;
end

