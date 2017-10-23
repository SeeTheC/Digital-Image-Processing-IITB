%% PCA Based Denoising

tic;
%% Initialization

file='../data/barbara256-part.png';
figure('name','Original Image');
img=imread(file);img=double(img);
%scale=1/2;img= imresize(img,scale);
cmGray256=gray(256);
imshow(img,colormap(cmGray256)),daspect([1,1,1]);

title('\fontsize{10}{\color{red}Barbara}'),o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1),axis tight,axis on;
%%  Adding Gaussian Noise to the image
noisyImg=img+randn(size(img)).*20;
figure('name','noisy Image');
imshow(noisyImg,colormap(cmGray256)),daspect([1,1,1]);
title('\fontsize{10}{\color{red}noisy barbara image}'),o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1),axis tight,axis on;

%% a) PCA denoising algo with Global PCA
tic
patchSize=7;sigma=20;
img1=myPCADenoising1(noisyImg,patchSize,sigma);
figure('name','Filtered Image');
imshow(img1,colormap(cmGray256)),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Filtered Image}'),o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1),axis tight,axis on;

meanSqError=sum(sum((img1-img).^2))/(size(img,1)*size(img,2));
fprintf('Global PCA Mean Sq Error:%f\n',meanSqError);

toc
%% b) PCA denoising algo using L similar patch

tic
patchSize=7;windowSize=31;L=200;sigma=20;
img2=myPCADenoising2(noisyImg,windowSize,patchSize,L,sigma);
figure('name','Denoised Image uisng 200 similar Patch');
cmGray256=colormap(gray(256));
imshow(img2,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Filtered Image using 200 similar patch}'),o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1),axis tight,axis on;

meanSqError=sum(sum((img2-img).^2))/(size(img,1)*size(img,2));
fprintf('Global PCA Mean Sq Error:%f\n',meanSqError);
toc;


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