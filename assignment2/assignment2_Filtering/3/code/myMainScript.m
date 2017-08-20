%% Intialization
file='../data/barbara.mat';
cmap=150;
scale=1/2;
l = load(file);
img1=l.imageOrig;
imgShrink = imresize(img1,scale);
tempImg=[1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25];
%% Patch base filtering
tic;
img=img1;
figure('name','Original Image');
imshow(img,colormap(gray(cmap)));
title('\fontsize{10}{\color{red}barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Corrupted - barbara');
[corrupted,filtered]=myPatchBasedFiltering(img,cmap,3,5,25);
imshow(corrupted,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Corrupted - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Patch Based Filter - barbara');
imshow(filtered,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Patch Based Filter - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
toc;
