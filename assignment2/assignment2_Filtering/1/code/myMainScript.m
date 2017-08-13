%% MyMainScript

tic;
%%
file='/home/ayush/mtech/subj3/dip/assignments/assignment2_Filtering/1/data/lionCrop.mat';
figure('name','Original Image');
img = importdata(file);
%cmGray256=colormap(gray(256));
imshow(img);
title('\fontsize{10}{\color{red}lionCrop}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%imagesc(img),daspect([1,1,1]),colormap(cmGray256),colorbar();
axis tight,axis on;
figure('name','Sharpened Image-lionCrop');
outImg=myUnsharpMasking(img);
imshow(outImg);
title('\fontsize{10}{\color{magenta}Sharpened Image-lionCrop}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

% b = imsharpen(img);
% figure, imshow(b)
% title('Sharpened Image');





toc;
