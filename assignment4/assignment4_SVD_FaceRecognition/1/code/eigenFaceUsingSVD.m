function [allImageMean,efaceNormalized,allImageDeviation]=eigenFaceUsingSVD(imgMatrix)
    % Computing allImageMean = (1/P)*sum(imgMatrix j's)    (j = 1 : P)
    allImageMean=mean(imgMatrix,2); % allImageMean=M*N x 1
    % Computing the deviation  X=M*N x P
    allImageDeviation=bsxfun(@minus, imgMatrix, allImageMean);        
    %V is eigen Vectors D is eigen Values A*V = V*D. Eigs: It will give the highest n-1 eigen value in sorted order        
    [U S V] = svd(allImageDeviation);   
    %Eigen Falce
    eigFace=U;            
    efaceSq=eigFace.^2;
    efaceDis=sum(efaceSq).^0.5;    
    col=size(eigFace,2);
    for i=1:col
        eigFace(:,i)= eigFace(:,i)./efaceDis';
    end
    efaceNormalized=eigFace;
end