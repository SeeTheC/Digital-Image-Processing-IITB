
%% myShrinkImageByFactor
tic;
file='../data/circles_concentric.png';
%imfinfo(file);
figure('name','Original Image');
img=imread(file);
cmGray256=colormap(gray(256));
imshow(img,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Concentric Circles}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%imagesc(img),daspect([1,1,1]),colormap(cmGray256),colorbar();
axis tight,axis on;

figure('name','Shrink Image by 2');
outImg=myShrinkImageByFactorD(img,2);
imshow(outImg,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta} Shrink Image by 2}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%Shrink Image By factor: 3
shrinkFig=figure('name','Shrink Image by 3');
outImg=myShrinkImageByFactorD(img,3);
imshow(outImg,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta} Shrink Image by 3}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
axis tight,axis on;

toc;
%% Bilinear Interpolation
tic

file='../data/barbaraSmall.png';
figure('name','Original Image: BarbaraSmall');
img=imread(file);
cmGray256=colormap(gray(256));
outBLImg=myBilinearInterpolation(img);
outNNImg=myNearestNeighborInterpolation(img);

imshow(img,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{red} Barbara Small }');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Enlarge: Bilinear Interpolation');
imshow(outBLImg,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Enlarge: Bilinear Interpolation}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Enlarge: Nearnest Neighbour Interpolation');
imshow(outNNImg,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Enlarge: Nearnest Neighbour Interpolation}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

