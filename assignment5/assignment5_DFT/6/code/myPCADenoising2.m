function [outImg]=myPCADenoising2(img,windowSize,patchSize,L,sigma)
    % padding zeros outside the image. For simple masking
    [row,col]=size(img);
    outImg=zeros(row,col); 
    pad=floor((windowSize-1)/2);
    imgPad=padarray(img,[pad,pad],0,'both');
    patchAddedCount=zeros(row,col);
    for i=1:1:row-patchSize+1
        for j=1:1:col-patchSize+1
            xi=i+pad;yi=j+pad;            
            filtValMat=PCAFilteredValue(imgPad,[xi,yi],windowSize,patchSize,L,sigma);
            
            [xp1,yp1,xp2,yp2]=getPatchCoordinate([i,j],patchSize);            
            outImg(xp1:xp2,yp1:yp2)=outImg(xp1:xp2,yp1:yp2)+filtValMat;
            patchAddedCount(xp1:xp2,yp1:yp2)=patchAddedCount(xp1:xp2,yp1:yp2)+1;
        end
    end
    outImg=outImg./patchAddedCount;  
end

function [filteredVal]=PCAFilteredValue(img,point,windowSize,patchSize,L,sigma)        
    [xw1,yw1,xw2,yw2]=getWindowCoordinate(point,windowSize);
    [xp1,yp1,xp2,yp2]=getPatchCoordinate(point,patchSize);    
    croppedImg=img(xw1:xw2,yw1:yw2);        
    refPatch=reshape(img(xp1:xp2,yp1:yp2),patchSize^2,1);
    
    [patchImg,dissimilarity]=convertImgToPatch(croppedImg,refPatch,patchSize);   
    [sorted,order]=sort(dissimilarity);
    similarPatch=patchImg(:,order(1:L));
     
    % to compute eigen vectors and eigen-coeff of P
    p=similarPatch;
    ppt=p*p';
    [v d]=eig(ppt);
    eignCoffMat=v'*p;
    eignCoffRefPatch=v'*refPatch;
   
    alphaBar=max(0,(sum(eignCoffMat.^2,2)./L)-(sigma^2));
    kFactor=1./(1+ (sigma^2./alphaBar));
    alphaEigenCoffDenoised=kFactor.*eignCoffRefPatch;   
    qDenoised=(v*alphaEigenCoffDenoised);
    filteredVal=reshape(qDenoised,patchSize,patchSize);
    
end

% Returns the  patchImg of dimension (patchSize^2)x (No. of patchs)
function [patchImg,dissimilarity]=convertImgToPatch(img,refVector,patchSize)
    [row,col]=size(img);
    % Init
    noOfPatch=(row-patchSize)*(col-patchSize);
    vectorSize=patchSize^2;
    patchImg=zeros(vectorSize,noOfPatch);
    dissimilarity=zeros(1,noOfPatch);
    pk=1;
    % Fetching patch from image and trasforming it into vector 
    for i=1:row-patchSize+1;
        for j=1:col-patchSize+1;
            [x1,y1,x2,y2]=getPatchCoordinate([i,j],patchSize);
            vector=reshape(img(x1:x2,y1:y2),vectorSize,1);
            patchImg(:,pk)=vector;
            dissimilarity(pk)=sum((vector-refVector).^2);
            pk=pk+1;
        end
    end        
end


% Getting Window Coordinate assuming point as center
function [x1,y1,x2,y2]=getWindowCoordinate(centerPoint,windowSize)
    x=centerPoint(1);y=centerPoint(2);
    halfSize=floor((windowSize-1)/2);
    x1=x-halfSize;y1=y-halfSize;    
    x2=x+halfSize;y2=y+halfSize; 
end

% Getting Patch Coordinate
function [x1,y1,x2,y2]=getPatchCoordinate(topLeftPoint,patchSize)
    x=topLeftPoint(1);y=topLeftPoint(2);           
    x1=x;y1=y;    
    x2=x+patchSize-1;y2=y+patchSize-1; 
end