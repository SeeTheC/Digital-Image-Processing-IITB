function [allImageMean,efaceNormalized,allImageDeviation]=eigenFace(imgMatrix)
    % Computing allImageMean = (1/P)*sum(imgMatrix j's)    (j = 1 : P)
    allImageMean=mean(imgMatrix,2); % allImageMean=M*N x 1
    % Computing the deviation  X=M*N x P
    allImageDeviation=bsxfun(@minus, imgMatrix, allImageMean);
    L = allImageDeviation'*allImageDeviation;
    %toCheckSemiPositivness=chol(L);
    %V is eigen Vectors D is eigen Values A*V = V*D. Eigs: It will give the highest n-1 eigen value in sorted order        
    [V D] = eigs(L,size(imgMatrix,2)-1);   
    %Eigen Falce
    eigFace=allImageDeviation * V;        
    %unit normalization
    %efaceMeanDiff=bsxfun(@minus, eigFace, mean(eigFace));
    %efaceNormalized= bsxfun(@times, efaceMeanDiff, 1./std(eigFace));
    efaceSq=eigFace.^2;
    efaceDis=sum(efaceSq).^0.5;
    efaceNormalized= bsxfun(@times, eigFace, 1./efaceDis);
end