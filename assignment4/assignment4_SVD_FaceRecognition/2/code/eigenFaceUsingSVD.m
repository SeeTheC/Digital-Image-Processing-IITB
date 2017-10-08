function [allImageMean,efaceNormalized,allImageDeviation]=eigenFaceUsingSVD(imgMatrix)
    % Computing allImageMean = (1/P)*sum(imgMatrix j's)    (j = 1 : P)
    allImageMean=mean(imgMatrix,2); % allImageMean=M*N x 1
    % Computing the deviation  X=M*N x P
    allImageDeviation=bsxfun(@minus, imgMatrix, allImageMean);     
    [U,S,V] = svd(allImageDeviation,'econ');       
    %Eigen Face
    [sorted,order]=sort(diag(S),'descend');
    U=U(:,order(1:end-1));%last eigen value is zero, so removing it
    eigFace=U;
    efaceSq=eigFace.^2;
    efaceDis=sum(efaceSq).^0.5;
    efaceNormalized= bsxfun(@times, eigFace, 1./efaceDis);      
end