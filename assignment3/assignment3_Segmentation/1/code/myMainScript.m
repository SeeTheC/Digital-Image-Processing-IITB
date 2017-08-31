%% Initialization
file='../data/boat.mat';
l = load(file);
img1=l.imageOrig;
img1=img1./255;
cmap=1;
img2=double(checkerboard>0.5);
%img2=imresize(img2,2);
%% Original image
tic;
img=img1;
figure('name','boat');
imshow(img);
title('\fontsize{10}{\color{red}Original Image}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
toc;

%% Harris corner detector
windowSize=7;
sigma=1.3;
blurSigma=0.01;
k=0.16;
[blurImg,cornernessMeasure,corners,SinglePointCorners,Ix,Iy] = myHarrisCornerDetector(img,windowSize,blurSigma,sigma,k);

% Guassian Blur Img
figure('name','Blur Img');
colormap(gray);
imshow(blurImg);
title('\fontsize{10}{\color{magenta}Guassian Blur Img}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
toc;


% Corner-ness Measure 
figure('name','Corner-ness Measure');
colormap(gray);
imshow(cornernessMeasure>0);
title('\fontsize{10}{\color{magenta}Corner-ness Measure}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
impixelinfo;
toc;
fprintf('Number of Corners:%d Single Piont\n',numel(corners),numel(SinglePointCorners));


% Marks the Points
figure('name','Corner Marked Image');
pos   = corners;
color = {'red'};
markedImage = insertMarker(img,pos,'x','color',color,'size',2);
imshow(markedImage);
title('\fontsize{10}{\color{magenta}Corner Marked Image}');
axis tight,axis on;
o1 = get(gca, 'Position');
set(gca, 'Position', o1);
impixelinfo;
toc;


% Marks the Filtered Points
figure('name','Filtered Corner');
pos   = SinglePointCorners;
color = {'yellow'};
markedImage = insertMarker(img,pos,'x','color',color,'size',2);
imshow(markedImage);
title('\fontsize{10}{\color{magenta} Filtered Corner: Taking max intensity corner in neighbourhood window 7 pixel}');
axis tight,axis on;
o1 = get(gca, 'Position');
set(gca, 'Position', o1);
impixelinfo;
toc;
%%

% X-Dervative
figure('name','X-Derivative');
imshow(Ix);
title('\fontsize{10}{\color{red}X-Derivative}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
toc;

% Y-Derivative 
figure('name','Y-Derivative');
imshow(Iy);
title('\fontsize{10}{\color{red}Y-Derivative}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
toc;

%%
% Corner-ness Measure 
figure('name','Corner-ness Measure');
colormap(gray);
imagesc(cornernessMeasure);
title('\fontsize{10}{\color{magenta}Corner-ness Measure}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
toc;


%% Edge
I=(Ix.^2+Iy.^2).^0.5;
figure('name','Edge');
%imagesc(out);
imshow(I,colormap(gray(255)));
