%% Assignment-2 Roll no: 163059009,16305R00_,16305R00_
%%
fileBarbara='../data/barbara.png';
fileTem='../data/TEM.png';
fileCanyon='../data/canyon.png';
imgBarbara=imread(fileBarbara);
imgTem=imread(fileTem);
imgCanyon=imread(fileCanyon);
%% Linear Contrast
tic
img=imgBarbara;
figure('name','Original Image: Barbara');
cmGray=colormap(gray(256));
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
title('\fontsize{10}{\color{red}Original Image: Barbara}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1)

out=myHE(img);
figure('name','Histogram Eq: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Histogram Eq: Barbara}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Histogram Eq: Barbara'),imhist(uint8(out));

%% Histogram Eq: Tem
img=imgTem;
figure('name','Original Image: Tem');
imshow(img,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: Tem}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

out=myHE(img);
figure('name','Histogram Eq: Tem');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Histogram Eq: Tem}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

figure('name','Histogram Eq: Tem'),imhist(uint8(out));

%% Histogram Eq: Canyon
tic
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: Canyon}');

out=myHE(img);
figure('name','Histogram Eq: Canyon');
imshow(uint8(out)),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}Histogram Eq: Canyon}');
toc
%% AHE : Barbara
tic
img=imgBarbara;
figure('name','Original Image: Barbara');
imshow(img,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: Barbara}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

out=myAHE(img,281);
figure('name','AHE: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Barbara with Window  281x281}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%figure('name','AHE: Barbara'),imhist(uint8(out));

out=myAHE(img,11);
figure('name','AHE: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Barbara with Window 11x11}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%figure('name','AHE: Barbara 2'),imhist(uint8(out));


out=myAHE(img,501);
figure('name','AHE: Barbara');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Barbara with Window 501x501}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%figure('name','AHE: Barbara 2'),imhist(uint8(out));

toc
%% AHE : TEM
tic
img=imgTem;
figure('name','Original Image: Tem');
imshow(img,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: Tem}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

out=myAHE(img,121);
figure('name','AHE: Tem');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Tem with Window 121x121}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%figure('name','AHE: Tem'),imhist(uint8(out));

out=myAHE(img,11);
figure('name','AHE: Tem');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Tem with Window 11x11}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%figure('name','AHE: Tem'),imhist(uint8(out));

out=myAHE(img,541);
figure('name','AHE: Tem');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Tem with Window 541x541}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%figure('name','AHE: Tem'),imhist(uint8(out));

toc

%% AHE : Canyon
tic
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{red}Original Image: Canyon}');

out=myAHE(img,221);
figure('name','AHE: Canyon');
imshow(uint8(out),cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Canyon with Window 221x221}');

out=myAHE(img,11);
figure('name','AHE: Canyon');
imshow(uint8(out),cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Canyon with Window 11x11}');

out=myAHE(img,343);
figure('name','AHE: Canyon');
imshow(uint8(out),cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}AHE: Canyon with Window 343x343}');

toc

%% CLAHE : Barbara
tic
img=imgBarbara;
figure('name','Original Image: Barbara');
imshow(img,cmGray),daspect([1,1,1]);

out=myCLAHE(img,251,0.2);
figure('name','CLAHE: Barbara with Window 251x251 and Threshold=0.2');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}CLAHE: Canyon with Window 251x251 and Threshold=0.2}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

out=myCLAHE(img,11,0.1);
figure('name','CLAHE: Barbara with Window 11x11 and Threshold=0.1');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}CLAHE: Canyon with Window 11x11 and Threshold=0.1}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

out=myCLAHE(img,511,0.2);
figure('name','CLAHE: Barbara with Window 511x511 and Threshold=0.1');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}CLAHE: Canyon with Window 511x511 and Threshold=0.1}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%figure('name','Histogram Eq: Barbara'),imhist(uint8(out));
toc

%% CLAHE : Tem

tic
img=imgTem;
figure('name','Original Image: Tem');
imshow(img,cmGray),daspect([1,1,1]);

out=myCLAHE(img,300,0.1);
figure('name','CLAHE: Tem with Window 251x251 and Threshold=0.2');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}CLAHE: Tem with Window 300x300 and Threshold=0.1}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

out=myCLAHE(img,11,0.05);
figure('name','CLAHE: Tem with Window 11x11 and Threshold=0.1');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}CLAHE: Tem with Window 11x11 and Threshold=0.5}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

out=myCLAHE(img,511,0.05);
figure('name','CLAHE: Tem with Window 511x511 and Threshold=0.1');
imshow(out,cmGray),daspect([1,1,1]);
title('\fontsize{10}{\color{magenta}CLAHE: Tem with Window 511x511 and Threshold=0.5}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%figure('name','Histogram Eq: Barbara'),imhist(uint8(out));
toc

%% CLAHE : Canyon

tic
img=imgCanyon;
figure('name','Original Image: Canyon');
imshow(img,cmGray),daspect([1,1,1]);
out=myCLAHE(img,101,0.005);
%figure('name','AHE Eq: Canyon:Red'),imhist(uint8(out(:,:,1)));
%figure('name','AHE Eq: Canyon:Green'),imhist(uint8(out(:,:,2)));
%figure('name','AHE Eq: Canyon:blue'),imhist(uint8(out(:,:,3)));
figure('name','CLAHE Eq: Canyon');
imshow(uint8(out),cmGray),daspect([1,1,1]);
toc