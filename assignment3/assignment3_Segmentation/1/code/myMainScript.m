%% Assignment 3 -- Question 1
% CS-663 Group-16305R011,163059009,16305R006
%% Initialization
% Initialize the boat image.Then rescale the intensities in the image to
% lie within the range [0, 1].
file='../data/boat.mat';
l = load(file);
img1=l.imageOrig;
img1=img1./255;
cmap=1;

%% Original image
% Showing Original Image
tic;
img=img1;
figure('name','boat');
imshow(img);
title('\fontsize{10}{\color{red}Original Image}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%% Harris corner detector
% myHarrisCornerDetector function take image, then it finds the x-derivative and y-derivative of the image.
% Now,for a given window size it calculates a structure tensor,given by
% following formula : 
%%
% 
% <<tensor.png>>
% 
% Then using following formula corner-ness C is calculated
%
% 
% $$C=Det(A)-k(Trace(A))^2$$
% 
% Now a pixel is declared a corner if C>0 holds.(Note:But for correction purpose we have talen C>0.01)
%
%


%% Parameters
%
% * windowSize=7
% * blurSigma=0.01 (Used to smooth the whole image)
% * sigma=1.3 (Used within structure tensor)
% * k=0.16 (empirically-tuned constant)
% 
%% Output: 
% Returns image marked with corners (corners shown with yellow crosses).
%

%% Harris Corner Detector
% myHarrisCornerDetector take 5 parameters as input.
% Returns the below things:
% 
% # smooth Image
% # cornernessMeasure Image
% # List corners coordinate in [y,x] format
% # List filtered corners coordinate in [y,x] format.
tic
windowSize=7;
sigma=1.3;
blurSigma=0.01;
k=0.16;
[smoothImg,cornernessMeasure,corners,filteredCorners,Ix,Iy] = myHarrisCornerDetector(img,windowSize,blurSigma,sigma,k);
toc
%% Smoothing of Image
figure('name','Smooth Image');
colormap(gray);
imshow(smoothImg);
title('\fontsize{10}{\color{magenta}Smooth Image: Using Guassian Blur}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%% X-Dervative
figure('name','X-Derivative');
imshow(Ix);
title('\fontsize{10}{\color{red}X-Derivative}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%% Y-Derivative 
figure('name','Y-Derivative');
imshow(Iy);
title('\fontsize{10}{\color{red}Y-Derivative}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%% Corner-ness Measure 
figure('name','Corner-ness Measure');
colormap(gray);
imshow(cornernessMeasure>0);
title('\fontsize{10}{\color{magenta}Corner-ness Measure}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%fprintf('Number of Corners:%d Single Piont\n',numel(corners),numel(SinglePointCorners));

%% Mark the All corners
% Marks all the corner given by harris corner detection algo.

figure('name','Corner Marked Image');
pos   = corners;
color = {'red'};
markedImage = insertMarker(img,pos,'x','color',color,'size',2);
imshow(markedImage);
title('\fontsize{10}{\color{magenta}Corner Marked Image}');
axis tight,axis on;
o1 = get(gca, 'Position');
set(gca, 'Position', o1);


%% Mark the Filtered Corners

% It selects a maximum intesity point from a given cluster of points. Gives
% better corner. Radius of the cluster considered is 7.
figure('name','Filtered Corner');
pos   = filteredCorners;
color = {'yellow'};
markedImage = insertMarker(img,pos,'x','color',color,'size',2);
imshow(markedImage);
title('\fontsize{10}{\color{magenta} Filtered Corner: Taking max intensity corner in neighbourhood window 7 pixel}');
axis tight,axis on;
o1 = get(gca, 'Position');
set(gca, 'Position', o1);
