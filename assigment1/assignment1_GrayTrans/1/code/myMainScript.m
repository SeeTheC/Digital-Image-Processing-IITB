%% MyMainScript

tic;
%% myShrinkImageByFactor
file='../data/circles_concentric.png';
%imfinfo(file);
figure('name','Original Image','rend','painters');
img=imread(file);
cmGray256=colormap(gray(256));
imshow(img,cmGray256),daspect([1,1,1]);
%colorbar();
%imagesc(img),daspect([1,1,1]),colormap(cmGray256),colorbar();
axis tight,axis on;

figure('name','Shrink Image by 2');
outImg=myShrinkImageByFactorD(img,2);
imshow(outImg,cmGray256),daspect([1,1,1]);
colorbar();
axis tight,axis on;

shrinkFig=figure('name','Shrink Image by 3');
outImg=myShrinkImageByFactorD(img,3);
imshow(outImg,cmGray256),daspect([1,1,1]);
colorbar();
axis tight,axis on;

toc;
%% Bilinear Interpolation

file='../data/barbaraSmall.png';
%imfinfo(file)
cmGray256=colormap(gray(256));

figure('name','Original Image');
imshow(img,cmGray256),daspect([1,1,1]);
axis tight,axis on;

img=imread(file);
outBLImg=myBilinearInterpolation(img);
outNNImg=myNearestNeighborInterpolation(img);


figure('name','Enlarge: Bilinear Interpolation');
imshow(outImg,cmGray256),daspect([1,1,1]);
axis tight,axis on;

figure('name','Enlarge: Nearnest Neighbour Interpolation');
imshow(outNNImg,cmGray256),daspect([1,1,1]);
axis tight,axis on;


