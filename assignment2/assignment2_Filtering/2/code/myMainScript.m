%% Intialization
file='../data/barbara.mat';
cmap=100;
l = load(file);
img1=l.imageOrig;
%% Bilateral filtering
tic;
img=img1;
sigmaSpace=10;
sigmaIntensity=25;
figure('name','Original Image');
imshow(img,colormap(gray(cmap)));
title('\fontsize{10}{\color{red}barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Corrupted - barbara');
[corrupted,filtered,spaceMask,rmsError]=myBilateralFiltering(img,cmap,41,sigmaSpace,sigmaIntensity);
imshow(corrupted,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Corrupted - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Bilateral Filter - barbara');
imshow(filtered,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Bilateral Filter - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Spatial Mask');
imshow(uint8(spaceMask*cmap),colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Spatial}');

% Finding RMS of image
fprintf('\nSigSpace:%d SigInt:%d  RMS of the image:%f\n',sigmaSpace,sigmaIntensity,rmsError);


% Comparison
figure('name','Output - barbara');
subplot(121);
imshow(corrupted,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Corrupted - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

subplot(122);
imshow(filtered,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Bilateral Filter - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

toc;
%%