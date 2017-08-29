%% MyMainScript

%% Initialization
tic;

fileBaboonColor='../data/baboonColor.png';
imgBaboonColor=imread(fileBaboonColor);
img=im2double(imgBaboonColor);
scale=1/4;

GaussianFilter=fspecial('gaussian',[100,100],1);
GaussianBlurImage=imfilter(img,GaussianFilter);
GaussianBlurResizedImage= imresize(GaussianBlurImage,scale);
toc
%%

figure('name','Original Image: baboonColor');
imshow(img);
title('\fontsize{10}{\color{red}Original Image: baboonColor}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
impixelinfo;

figure('name','OGaussianBlurResizedImage: baboonColor');
imshow(GaussianBlurResizedImage);
title('\fontsize{10}{\color{red}GaussianBlurResizedImage: baboonColor}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
impixelinfo;
%%
tic 
% best: 5 0.075 1
%
out=myMeanShiftSegmentation(GaussianBlurResizedImage,5,0.12,1.4);
figure('name','myMeanShiftSegmentation: baboonColor');
imshow(out);
title('\fontsize{10}{\color{magenta}myMeanShiftSegmentation: baboonColor}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1); 
impixelinfo;
toc;
