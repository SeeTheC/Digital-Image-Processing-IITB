% Test a=[1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25]
% NxN = 3x3
% Run; myAHE1(uint8(a),3)
function outImg = myCLAHE(img,windowSize,hThershold)
% Adaptive Histogram Equalization: AHE
    [m,n,k]=size(img);
    z=zeros(m,n,k);  
    tempHThershold=hThershold;   
    for layer=1:1:k
        maskCoordinate=[];
        histogram=zeros(256,1);    
        layerImg=img(:,:,layer);
        if(k==3)
            hThershold=tempHThershold(k);            
        end 
        for row=1:2:m        
            % Scan: Left -> Right
            for col=1:1:n
                [val,maskCoordinate,histogram]=getIntesity(layerImg,[row,col],windowSize,maskCoordinate,histogram,hThershold);   
                z(row,col,layer)=val;    
            end

            if(row+1>m)
                % safe gaurd if no. of rows is odd
                break;
            end

            %disp('<<<----------- Reverse-----');
            % Scan: Right -> Left
            for col=n:-1:1
                   [val,maskCoordinate,histogram]=getIntesity(layerImg,[row+1,col],windowSize,maskCoordinate,histogram,hThershold);     
                   z(row+1,col,layer)=val;     
            end
        end
        outImg=z;
    end
end


% Finds new enhanced intensity by using AHE algo and by NxN window size;
% Note: In NxN, N is always ODD. like 3,5,7,
% At at border the portion of window is trimmed which is going out of
% image.
function [newVal,maskCoordinate,newHistogram]=getIntesity(img,coordinate,windowSize,oldMaskCoordinate,histogram,hThershold)    
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
   
    
    %fprintf('x=%d y=%d \nx1=%d y1=%d \nx2=%d y2=%d\n',x,y,x1,y1,x2,y2);
    if(isempty(oldMaskCoordinate)) %first-time
        [histogram,binlocation]=imhist(img(x1:x2,y1:y2));                                         
    else
        ox1=oldMaskCoordinate(1);oy1=oldMaskCoordinate(2);
        ox2=oldMaskCoordinate(3);oy2=oldMaskCoordinate(4);
    
        %fprintf('ox1=%d oy1=%d \n ox2=%d oy2=%d \n',ox1,oy1,ox2,oy2);
    
        % Note: Block of NxN is from Left to Right i.e incrementing y then
        % Right to Left.         
        % That is at the right end move block DOWN by 1 the start moving
        % from Right to Left
        
        %disp('Old Histogram');
        %disp(histogram);
        % Removing the old intensity count and Adding new intensity count                
        
        if(oy1 == y1 && oy2<y2) % Col Operation
            % Block Moved : Left -> Right            
            for i=ox1:1:ox2                
                val=img(i,y2);  % new col: Add
                histogram(val+1)=histogram(val+1)+1;
            end            
        elseif(oy1 ~= y1 && oy1<y1) % Col Operation
            % Block Moved : Left -> Right            
            for i=ox1:1:ox2
                val=img(i,oy1); % old col: Remove
                histogram(val+1)=histogram(val+1)-1;
                
                if(y2 ~=oy2) % border condition
                    val=img(i,y2);  % new col: Add
                    histogram(val+1)=histogram(val+1)+1;
                end
            end    
        elseif(oy2 == y2 && oy1>y1)  % Col Operation
            % Block Moved: Left <- Right
            for i=ox1:1:ox2 % border condition                                
                val=img(i,y1); % new col: Add
                histogram(val+1)=histogram(val+1)+1;                
            end
            
        elseif(oy2 ~= y2 && oy2>y2)  % Col Operation
            % Block Moved: Left <- Right
            for i=ox1:1:ox2
                val=img(i,oy2); % old col: Remove
                histogram(val+1)=histogram(val+1)-1;
                
                if(y1 ~=oy1)% border condition                
                    val=img(i,y1); % new col: Add
                    histogram(val+1)=histogram(val+1)+1;
                end
            end
            
        elseif(ox1 == x1 && ox2<x2)  % Row Operation
            % Block Moved: Up -> Down
            for i=oy1:1:oy2 % border condition
                val=img(x2,i); % new row: Add
                histogram(val+1)=histogram(val+1)+1;                    
            end
            
        elseif(ox1 ~= x1 && ox1<x1)  % Row Operation
            % Block Moved: Up -> Down
            for i=oy1:1:oy2                
                val=img(ox1,i); % old row: Remove
                histogram(val+1)=histogram(val+1)-1;
                
                if(x2 ~=ox2) % border condition
                    val=img(x2,i); % new row: Add
                    histogram(val+1)=histogram(val+1)+1;                    
                end
            end
        end 
        
        %disp('New Histogram');
        %disp(histogram);
    end
    
    
    totalPixel= (x2-x1+1)*(y2-y1+1);
    thershlodFreq=floor(hThershold*totalPixel);
    copyHist=histogram;
    
    numberOfIntensity=sum(copyHist>0);
    exceedingIntensity=copyHist(copyHist>thershlodFreq);
    countExceedingFreq=sum(exceedingIntensity)-(thershlodFreq*length(exceedingIntensity));
    perIntensityDistribution=floor(countExceedingFreq/numberOfIntensity);
    %disp(max(copyHist))
    if( ~isempty(exceedingIntensity) && perIntensityDistribution>0)   
        %fprintf('pInte=%d\n',perIntensityDistribution);
        for i=1:1:256
            % Redistribute the exceeded frequency 
            if(copyHist(i) ~= 0)
                if(copyHist(i) <= thershlodFreq)
                    copyHist(i)=copyHist(i)+perIntensityDistribution;
                elseif(copyHist(i) > thershlodFreq)
                    copyHist(i)=copyHist(i)-thershlodFreq+perIntensityDistribution;
                end

            end
        end
    end
    val=img(x,y);        
    z=val;     
    % Calculating  cumulative distribution of each intensity
    cDist=0;
    for i=1:1:256
        ithProb=copyHist(i)/totalPixel;
        cDist=ithProb+cDist;
        if(i==val+1)
            z=cDist*255;
            break;
        end
    end
    
    newVal=z;
    maskCoordinate=[x1,y1,x2,y2];
    newHistogram=histogram;
end
