%%
dim=[5,5];
sigma=1;
row=dim(1);col=dim(1);    
centerX=ceil(row/2);centerY=ceil(col/2);
[r,c] = ndgrid(1:dim, 1:dim);
% Xi-x
xDiff=r-centerX;
% Yi-y
yDiff=c-centerX;
% Taking Sq (Xi-x)^2 & (Yi-y)^2
xDiffSq=xDiff.^2;
yDiffSq=yDiff.^2;    
% Eucledian Norm ||P-Q||^2 i..  ( sqrt ( (Xi-x)^2 & (Yi-y)^2 ) )^2
norm=xDiffSq+yDiffSq;
mask=norm;

exponent=mask./(2*sigma^2);   
%amplitude = 1 / (sigma * sqrt(2*pi));  
amplitude=1;
gaussianMask = amplitude .* exp(-exponent);
