%% Initialization
file='../data/boat.mat';
l = load(file);
img1=l.imageOrig;
img1=img1./255;
cmap=1;
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
%hold on;
%plot(100,100,'r.','MarkerSize',20)

%% Harris corner detector
windowSize=25;
sigma=0.6;
blurSigma=0.7;
k=0.001;
[blurImg,cornernessMeasure,corners,Ix,Iy] = myHarrisCornerDetector(img,windowSize,blurSigma,sigma,k);

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
imagesc(cornernessMeasure);
title('\fontsize{10}{\color{magenta}Corner-ness Measure}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
toc;

% Marks the Points
figure('name','Corner Marked Image');
pos   = corners;
color = {'red'};
markedImage = insertMarker(img,pos,'x','color',color,'size',5);
imshow(markedImage);
title('\fontsize{10}{\color{magenta}Corner Marked Image}');
axis tight,axis on;
o1 = get(gca, 'Position');
set(gca, 'Position', o1);
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
