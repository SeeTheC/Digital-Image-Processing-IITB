%% Assignment-2 Roll no: 163059009,16305R00_,16305R00_
fileBarbara='../data/barbara.png';
fileTem='../data/TEM.png';
fileCanyon='../data/canyon.png';
file='/media/khursheed/DATA/photo/farewell 2013/photo1028.jpg';
cmGray=colormap(gray(256));
imgBarbara=imread(fileBarbara);
imgTem=imread(fileTem);
imgCanyon=imread(fileCanyon);
tempImg=imread(file);

%imfinfo(imgCanyon)
tic;
%% Linear Contrast

img=imgBarbara;
figure('name','Original Image: Barbara');
imshow(img,cmGray),daspect([1,1,1]);
[out,intensities]=myLinearContrastStretching(img,[10,7],[180,220]);
figure('name','Contrast Plot');plot([0:255],intensities);
figure('name','Contrast Image: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
%% Linear Contrast: Temp
img=imgTem;
figure('name','Original Image: TEM');
imshow(img,cmGray),daspect([1,1,1]);
[out,intensities]=myLinearContrastStretching(img,[100,40],[180,220]);
figure('name','Contrast Plot');plot([0:255],intensities);
figure('name','Contrast Image: TEM');
imshow(out,cmGray),daspect([1,1,1]);
%% Linear Contrast: Canyon
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img),daspect([1,1,1]);
[out,intensities]=myLinearContrastStretching(img,[80,40],[180,200]);
figure('name','Contrast Plot');plot([0:255],intensities);
figure('name','Contrast Image: Canyon');
imshow(uint8(out)),daspect([1,1,1]);

%% Histogram Eq: Barbara

img=imgBarbara;
figure('name','Original Image: Barbara');
imshow(img,cmGray),daspect([1,1,1]);
out=myHE(img);
figure('name','Histogram Eq: Barbara'),imhist(uint8(out));
figure('name','Histogram Eq: Barbara');
imshow(out,cmGray),daspect([1,1,1]);

%% Histogram Eq: Tem
img=imgTem;
figure('name','Original Image: Tem');
imshow(img,cmGray),daspect([1,1,1]);
out=myHE(img);
figure('name','Histogram Eq: Tem'),imhist(uint8(out));
figure('name','Histogram Eq: Tem');
imshow(out,cmGray),daspect([1,1,1]);

%% Histogram Eq: Canyon
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img,cmGray),daspect([1,1,1]);
out=myHE(img);
%figure('name','Histogram Eq: Canyon'),imhist(uint8(out));
figure('name','Histogram Eq: Canyon');
imshow(uint8(out)),daspect([1,1,1]);

%% AHE : Barbara
tic
img=imgBarbara;
figure('name','Original Image: Barbara');
imshow(img,cmGray),daspect([1,1,1]);
out=myAHE1(img,201);
figure('name','Histogram Eq: Barbara'),imhist(uint8(out));
figure('name','Histogram Eq: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
toc
%% AHE : TEM
tic
%ticBytes(gcp);
img=imgTem;
figure('name','Original Image: Tem');
imshow(img,cmGray),daspect([1,1,1]);
out=myAHE1(img,121);
figure('name','Histogram Eq: Tem'),imhist(uint8(out));
figure('name','Histogram Eq: Tem');
imshow(out,cmGray),daspect([1,1,1]);
%tocBytes(gcp);
toc

%% AHE : Canyon
tic
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img,cmGray),daspect([1,1,1]);
out=myAHE1(img,255);
figure('name','Histogram Eq: Canyon');
imshow(uint8(out),cmGray),daspect([1,1,1]);
toc
%%
img=imgBarbara;
img1=adapthisteq(uint8(img));
imshow(img1)
toc;
