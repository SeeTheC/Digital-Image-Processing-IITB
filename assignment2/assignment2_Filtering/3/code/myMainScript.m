%% Assignment 1 -- Question 1
% CS-663 Group-16305R011,163059009,16305R006

%% Intialization
file='../data/barbara.mat';
cmap=150;
scale=1/2;
l = load(file);
img1=l.imageOrig;
imgShrink = imresize(img1,scale);
GaussianFilter=fspecial('gaussian',[9,9],0.66);
GaussianBlurResizedImage=imfilter(imgShrink,GaussianFilter);
%% Original Image
tic;
img=GaussianBlurResizedImage;
figure('name','Original Image');
imshow(GaussianBlurResizedImage,colormap(gray(cmap)));
title('\fontsize{10}{\color{red}barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%% Patch base filtering
% myPatchBasedFiltering function take image, then it corrupts the image by
% Guassain nosie with sigma 5% of the intensity range. After that it
% process the noisy by the Patch Based filtering. For performing the Patch Based filtering 
% for *Intensity* region it use Gaussian Kernel with below configuration 
% as input: 
%
%
% * Sigma (h): 26
% 
% * Window Size: 25x25
% * Patch Size: 9x9
% 

% *Output:* Returns three thing respectively
%
% # Corruted/Noisy image 
% # Filtered Image
% # 
%

%% Assumptions made
% We resize the image by subsampling by a factor of 2 along each dimension,
% and then applied Gaussian blur of standard deviation around 0.66 pixel width to the resized image.
% This is done to reduce the time of the code
%% Comparison: Tuned parameter
% Comparing the result of filtered image with corrupted and original image.
% *RMSD* is calculated between filtered and blurred(gaussian) downsampled image.
% 
% <<rmsd.jpg>>
% 
%% Time Taken achal
% myPatchBasedFiltering takes approx 250 sec to produce result

%% Observation
% With increasing sigma value RMSD value decrease but only to a certain value then it becomes constant.
%% Tuned-h = 26
tic
sigma=2;
h=26;
[corrupted,filtered,patchMask]=myPatchBasedFiltering(img,cmap,9,25,sigma,h);
figure('name','barbara','units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imshow(corrupted,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Corrupted}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

subplot(1,2,2);
imshow(filtered,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Patch Based Filter}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

% Printing result
rmsError=sqrt(sum(sum((filtered-imgShrink).^2))/numel(imgShrink));
fprintf('sigma:%d h:%d RMS of the image blur:%f\n',sigma,h,rmsError);
%sigma:2 h:26 RMS of the image blur:6.784701
%Elapsed time is 33.750161 seconds.
toc
pause(2);

%% Kernel
%mask used to make patches isotropic, as an image.
figure('name','Isotropic Mask');
title('\fontsize{10}{\color{magenta} Mask used to make patches isotropic, as an image.}');
imagesc(uint8(patchMask*cmap)),colormap(gray(cmap)),colorbar();
pause(2);
%%
% i) Comparison: (0.9 x tuned-sigma-intensity) 
[corrupted,filtered,patchMask]=myPatchBasedFiltering(img,cmap,9,25,sigma,0.9*h);
figure('name','barbara','units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imshow(corrupted,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Corrupted}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

subplot(1,2,2);
imshow(filtered,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Patch Based Filter-[sigma-intesity=0.9*50]}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

% Printing result
rmsError=sqrt(sum(sum((filtered-imgShrink).^2))/numel(imgShrink));
fprintf('sigma:%d h:%d RMS of the image blur:%f\n',sigma,h,rmsError);

%%
% ii) Comparison: (1.1 x tuned-sigma-intensity) 

[corrupted,filtered,patchMask]=myPatchBasedFiltering(img,cmap,9,25,sigma, 1.1*h);
figure('name','barbara','units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imshow(corrupted,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Corrupted}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

subplot(1,2,2);
imshow(filtered,colormap(gray(cmap)));
title('\fontsize{10}{\color{magenta}Patch Based Filter-[sigma-intesity=1.1*50]}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

% Printing result
rmsError=sqrt(sum(sum((filtered-imgShrink).^2))/numel(imgShrink));
fprintf('sigma:%d h:%d RMS of the image blur:%f\n',sigma,h,rmsError);

toc;