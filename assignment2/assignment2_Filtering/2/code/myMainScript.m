%% Intialization
file='../data/barbara.mat';
l = load(file);
img1=l.imageOrig;
%% Bilateral filtering
tic;
img=img1;
figure('name','Original Image');
imshow(img,colormap(gray(256)));
title('\fontsize{10}{\color{red}barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','bifilter - barbara');
[corrupted,filtered]=myBilateralFiltering(img);
imshow(corrupted,colormap(gray(256)));
title('\fontsize{10}{\color{magenta}Corrupted - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

toc;

%%

figure;
sigma=0.05*256;
imshow(j,colormap(gray(256)));
k=uint8(img1)-j;
%I = imread('eight.tif');
%J = imnoise(I,'salt & pepper',0.02);
%figure, imshow(I);
%figure, imshow(J);
%%

