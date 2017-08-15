%% Intialization
file='../data/barbara.mat';
l = load(file);
img1=l.imageOrig;
testImg1=[1 2 3 4 5;4 5 6 7 8; 7 8 9 10 11;1 2 3 4 5;4 5 6 7 8];
testImg2=[1 2 3 ;4 5 6 ; 7 8 9 ];
%% Bilateral filtering
tic;
img=img1;
figure('name','Original Image');
imshow(img,colormap(gray(256)));
title('\fontsize{10}{\color{red}barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Corrupted - barbara');
[corrupted,filtered,spaceMask]=myBilateralFiltering(img,41,8,32);
imshow(corrupted,colormap(gray(256)));
title('\fontsize{10}{\color{magenta}Corrupted - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Bilateral Filter - barbara');
imshow(filtered,colormap(gray(256)));
title('\fontsize{10}{\color{magenta}Bilateral Filter - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Spatial Mask');
imshow(uint8(spaceMask*255),colormap(gray(256)));
title('\fontsize{10}{\color{magenta}Spatial}');

% Finding RMS of image
rms=sqrt(sum(sum((filtered-img1).^2))/numel(img1));
fprintf('RMS of the image:%f\n\n',rms);


% 101,50,25, Error:104
% 101,25,50, Error:166
% 51,40,30,  Error:92.366470
% 41,40,30   Error:82.239578
% 41,30,30   Error:81.144211
% 41,30,25   E:72.480927
% 101,10,25  E:62.077827 till now Best
% 101,10,20  E:61.589687 \
%------------ ^^^ SQ. Take root of it
% 41,8,32  E:7.882823
% 41,8,25  E:7.458076


% Comparison
figure('name','Output - barbara');
subplot(121);
imshow(corrupted,colormap(gray(256)));
title('\fontsize{10}{\color{magenta}Corrupted - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

subplot(122);
imshow(filtered,colormap(gray(256)));
title('\fontsize{10}{\color{magenta}Bilateral Filter - barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

toc;
%%
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

