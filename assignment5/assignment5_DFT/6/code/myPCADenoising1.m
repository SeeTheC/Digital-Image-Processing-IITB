function [ outImg ] = myPCADenoising1(img,patchSize,sigma)
    % PCA based Denoising
    patchImg=convertImgToPatch(img,patchSize);   
    noOfPatch=size(patchImg,2);
    ppt=patchImg*patchImg';
    [v d]=eig(ppt);
    eignCoffMat=v'*patchImg;
    alphaBar=max(0,(sum(eignCoffMat.^2,2)./noOfPatch)-(sigma^2));
    % kj= 1/1+ (sigma/alphaBar(j))
    kFactor=1./(1+ (sigma^2./alphaBar));
    betaDenoised=bsxfun(@times,eignCoffMat,kFactor);
    denoisePatch=v*betaDenoised;
    outImg=convertPatchToImg(denoisePatch,patchSize,size(img));
end

% Returns the  patchImg of dimension (patchSize^2)x (No. of patchs)
function [patchImg]=convertImgToPatch(img,patchSize)
    [row,col]=size(img);
    % Init
    noOfPatch=(row-patchSize)*(col-patchSize);
    vectorSize=patchSize^2;
    patchImg=zeros(vectorSize,noOfPatch);
    pk=1;
    % Fetching patch from image and trasforming it into vector 
    for i=1:row-patchSize+1;
        for j=1:col-patchSize+1;
            [x1,y1,x2,y2]=getPatchCoordinate([i,j],patchSize);
            vector=reshape(img(x1:x2,y1:y2),vectorSize,1);
            patchImg(:,pk)=vector;
            pk=pk+1;
        end
    end        
end

function [img]=convertPatchToImg(patchImg,patchSize,dim)  
    % Init    
    row=dim(1);col=dim(2);
    img=zeros(row,col);
    patchAddedCount=zeros(row,col);
    pk=1;
    % Fetching patch from image and trasforming it into vector 
    for i=1:row-patchSize+1;
        for j=1:col-patchSize+1;
            [x1,y1,x2,y2]=getPatchCoordinate([i,j],patchSize);
            mat=reshape(patchImg(:,pk),patchSize,patchSize);           
            img(x1:x2,y1:y2)=img(x1:x2,y1:y2)+mat;
            patchAddedCount(x1:x2,y1:y2)=patchAddedCount(x1:x2,y1:y2)+1;
            pk=pk+1;
        end
    end
    img=img./patchAddedCount;
end

% Getting Patch Coordinate
function [x1,y1,x2,y2]=getPatchCoordinate(topLeftPoint,patchSize)
    x=topLeftPoint(1);y=topLeftPoint(2);           
    x1=x;y1=y;    
    x2=x+patchSize-1;y2=y+patchSize-1; 
end
