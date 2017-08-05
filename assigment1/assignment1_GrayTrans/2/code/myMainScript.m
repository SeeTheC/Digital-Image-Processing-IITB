%% Assignment-2 Roll no: 163059009,16305R00_,16305R00_
fileBarbara='../data/barbara.png';
fileTem='../data/TEM.png';
fileCanyon='../data/canyon.png';
cmGray=colormap(gray(256));
imgBarbara=imread(fileBarbara);
imgTem=imread(fileTem);
imgCanyon=imread(fileCanyon);


%% Linear Contrast
tic
img=imgBarbara;
figure('name','Original Image: Barbara');
imshow(img,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: Barbara}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

[out,intensities]=myLinearContrastStretching(img,[90,60],[180,230]);
figure('name','Contrast Image: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Contrast Image: Barbara}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Contrast Plot'),plot([0:255],intensities),xlim([0 255]),ylim([0 255]);
title('\fontsize{10}{\color{magenta}Contrast Plot}');

%% Linear Contrast: Temp
img=imgTem;
figure('name','Original Image: TEM');
imshow(img,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: TEM}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

[out,intensities]=myLinearContrastStretching(img,[130,30],[180,220]);
figure('name','Contrast Image: TEM');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Contrast Image: TEM}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Contrast Plot');plot([0:255],intensities),xlim([0 255]),ylim([0 255]);
title('\fontsize{10}{\color{magenta}Contrast Plot}');

%% Linear Contrast: Canyon
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: Canyon}');
[out,intensities]=myLinearContrastStretching(img,[40,20],[160,200]);
figure('name','Contrast Plot');plot([0:255],intensities),xlim([0 255]),ylim([0 255]);
figure('name','Contrast Image: Canyon');
imshow(uint8(out)),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Contrast Image: Canyon}');


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
out=myAHE1(img,151);
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
figure('name','AHE: Tem'),imhist(uint8(out));
figure('name','AHE: Tem');
imshow(out,cmGray),daspect([1,1,1]);
%tocBytes(gcp);
toc

%% AHE : Canyon
tic
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img,cmGray),daspect([1,1,1]);
out=myAHE1(img,161);
figure('name','AHE Eq: Canyon:Red'),imhist(uint8(out(:,:,1)));
figure('name','AHE Eq: Canyon:Green'),imhist(uint8(out(:,:,2)));
figure('name','AHE Eq: Canyon:blue'),imhist(uint8(out(:,:,3)));
figure('name','AHE Eq: Canyon');
imshow(uint8(out),cmGray),daspect([1,1,1]);
toc
%%
%%
%% CLAHE : Barbara
tic
img=imgBarbara;
figure('name','Original Image: Barbara');
imshow(img,cmGray),daspect([1,1,1]);
out=myCLAHE(img,201,0.01);
figure('name','Histogram Eq: Barbara'),imhist(uint8(out));
figure('name','Histogram Eq: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
toc

%% CLAHE : Canyon
tic
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img,cmGray),daspect([1,1,1]);
out=myCLAHE(img,101,0.005);
figure('name','AHE Eq: Canyon:Red'),imhist(uint8(out(:,:,1)));
figure('name','AHE Eq: Canyon:Green'),imhist(uint8(out(:,:,2)));
figure('name','AHE Eq: Canyon:blue'),imhist(uint8(out(:,:,3)));
figure('name','AHE Eq: Canyon');
imshow(uint8(out),cmGray),daspect([1,1,1]);
toc