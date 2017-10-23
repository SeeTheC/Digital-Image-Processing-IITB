function [img2]=myPCADenoising2(img1,windowSize,patchSize,L,sigma)
    % padding zeros outside the image. For simple masking
    [row,col]=size(img1);
    pad=floor((windowSize+patchSize)/2);
    paddedCorruptedImage= [ zeros(row,pad) img1 zeros(row,pad)];
    paddedCorruptedImage= [ zeros(pad,col+(2*pad));paddedCorruptedImage;zeros(pad,col+(2*pad))];
    img2=zeros((row+patchSize),(col+patchSize));
    
    for i=1:1:row
        for j=1:1:col
            %fprintf('%d',i);
            filtValMat=PCAFilteredValue(paddedCorruptedImage,[(i+pad) (j+pad)],windowSize,patchSize,L,sigma);
            [xp1,yp1,xp2,yp2]=getPatchCoordinate(patchSize,[floor(i+patchSize/2) floor(j+patchSize/2)]);
            img2(xp1:xp2,yp1:yp2)=img2(xp1:xp2,yp1:yp2)+filtValMat;
        end
    end
    
    img2=img2./(patchSize*patchSize);%wrong at border
    img2=img2(patchSize/2:end-(patchSize/2+1),patchSize/2:end-(patchSize/2+1));
end
function [filteredVal]=PCAFilteredValue(img,point,windowSize,patchSize,L,sigma)
    [x1,y1,x2,y2]=getWindowCoordinate(windowSize,patchSize,point);
    imgWindow=img(x1:x2,y1:y2);
    % get ref patch
    [xp1,yp1,xp2,yp2]=getPatchCoordinate(patchSize,point);
    imgPatch=img(xp1:xp2,yp1:yp2);
    % creating P matrix of size (patchSize^2)*L
    lLeastVal=zeros(L,3);
    meanSquareValues=zeros(windowSize,windowSize);
    for i=1:1:windowSize
        for j=1:1:windowSize
            sx=(i+floor((patchSize+1)/2));sy=(j+floor((patchSize+1)/2));            
            meanSquareValues(i,j)=meanValues(imgWindow,imgPatch,[sx sy],patchSize);
            if L>=((i-1)*windowSize+j)
                lLeastVal(((i-1)*windowSize+j),1)=meanSquareValues(i,j);
                lLeastVal(((i-1)*windowSize+j),2)=sx;
                lLeastVal(((i-1)*windowSize+j),3)=sy;
            else
                if (L==((i-1)*windowSize+j+1))
                    lLeastVal=sortrows(lLeastVal,1);
                end
                for p=1:1:L
                    if meanSquareValues(i,j)<lLeastVal(p,1)
                        lLeastVal(L,1)=meanSquareValues(i,j);
                        lLeastVal(L,2)=sx;
                        lLeastVal(L,3)=sy;
                        lLeastVal=sortrows(lLeastVal,1);
                        break
                    end
                end
            end
        end
    end
    
    rowP=patchSize^2;colP=L;
    P=zeros(rowP,colP);
    for l=1:1:L
        [x1,y1,x2,y2]=getPatchCoordinate(patchSize,[lLeastVal(l,2) lLeastVal(l,3)]);
        patchs=imgWindow(x1:x2,y1:y2);
        vector = reshape(patchs,patchSize*patchSize,1);
        P(:,l)=vector;
    end
    % to compute eigen vectors and eigen-coeff of P
    [V D] = eig(P*P'); 
    VT=V';
    alphaEigenCoff=VT*P;
    % Wiener Filter
    alphaijSq=alphaEigenCoff.^2;
    alphaijSqSum=sum(alphaijSq,2)/L;
    alphaj=alphaijSqSum-sigma^2;
    alphaj=(alphaj>0).*alphaj;
    k=1./(1.+((sigma^2)./alphaj));
    alphaEigenCoffDenoised=k.*alphaEigenCoff(:,1);
    filteredVal=reshape((V*alphaEigenCoffDenoised),patchSize,patchSize);
end

function [meanVal]=meanValues(img,patchq,point,patchSize)
    [x1,y1,x2,y2]=getPatchCoordinate(patchSize,point);
    patchs=img(x1:x2,y1:y2);
    intensityDiff=(patchq-patchs);
    intensityDiffSq=intensityDiff.^2;
    meanVal=sum(sum(intensityDiffSq));
end

% Return the [x1 y1 x2 y2] coordinate of window with center as centerCoordinate
function [x1,y1,x2,y2]=getWindowCoordinate(windowSize,patchSize,centerCoordinate)
    %m=imageDim(1);n=imageDim(2);
    x=centerCoordinate(1);y=centerCoordinate(2);    
    N=floor((windowSize+patchSize)/2);
    x1=x-N;
    x2=x+N;
    y1=y-N;
    y2=y+N;
 
end


function [x1,y1,x2,y2]=getPatchCoordinate(patchSize,centerCoordinate)
    %m=imageDim(1);n=imageDim(2);
    x=centerCoordinate(1);y=centerCoordinate(2);    
    N=floor((patchSize-1)/2);   
    x1=x-N;
    x2=x+N;
    y1=y-N;
    y2=y+N;
 
end