%% MyMainScript

tic;
%% Initialization

file='../data/barbara256.png';
figure('name','Original Image');
scale=1/2;
img=imread(file);
imgResize= imresize(img,scale);
cmGray256=gray(256);
imshow(imgResize,colormap(cmGray256)),daspect([1,1,1]);

title('\fontsize{10}{\color{red}Barbara}'),o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1),axis tight,axis on;
%%  Adding Gaussian Noise to the image
noisyImg=double(imgResize)+randn(size(imgResize)).*20;
figure('name','noisy Image');
imshow(noisyImg,colormap(cmGray256)),daspect([1,1,1]);
title('\fontsize{10}{\color{red}noisy barbara image}'),o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1),axis tight,axis on;

%% a) PCA denoising algo
tic
patchSize=7;sigma=20;
img1=myPCADenoising1(noisyImg,patchSize,sigma);
figure('name','Filtered Image');
imshow(img1,colormap(cmGray256)),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Filtered Image}'),o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1),axis tight,axis on;

%% b) PCA denoising algo
%{
tic
patchSize=7;
windowSize=25;
L=150;
sigma=20;
img2=myPCADenoising1(img1,windowSize,patchSize,L,sigma);
figure('name','Denoised Image');
cmGray256=colormap(gray(256));
imshow(img2,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{red}denoised barbara image using PCA}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
axis tight,axis on;

toc;
%}