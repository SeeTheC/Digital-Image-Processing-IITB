%% MyMainScript

tic;
%% Your code here
file='../data/barbara256.png';
figure('name','Original Image');
img=imread(file);
cmGray256=colormap(gray(256));
imshow(img,cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{red}barbara}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
%imagesc(img),daspect([1,1,1]),colormap(cmGray256),colorbar();
axis tight,axis on;
%% Zero padding
[row,col]=size(img);
imgPad = zeros(2*row,2*col);
imgPad((row/2):3*(row/2)-1,(col/2):3*(col/2)-1) = img(:,:); 

%%
fimg = fftshift(fft2(imgPad));
absfimg = log(abs(fimg)+1);
figure('name','Fourier Transform');
imshow(absfimg,[min(absfimg(:)) max(absfimg(:))]);
colormap (jet); colorbar;
%max(absfimg(:))
lowPassH=lowpass(absfimg,80);
min(lowPassH(:));
G=fimg.*lowPassH;
figure('name','Filter');
imshow(lowPassH); colorbar;
axis tight,axis on;
%%
ifimg=ifft2(ifftshift(G));
figure('name','LPHImage');
%imshow(ifimg,cmGray256),daspect([1,1,1]);
imshow(ifimg(128:383,128:383),cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{red}barbara with lph applied}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
axis tight,axis on;



%% Gaussian Low Pass Filter
lowPassH=gaussianLowPass(absfimg,0.3);
min(lowPassH(:));
Ggauss=fimg.*lowPassH;
figure('name','Filter');
imshow(lowPassH); colorbar;
axis tight,axis on;
%%
ifimg=ifft2(ifftshift(Ggauss));
figure('name','gaussLPFImage');
%imshow(ifimg,cmGray256),daspect([1,1,1]);
imshow(ifimg(128:383,128:383),cmGray256),daspect([1,1,1]);
title('\fontsize{10}{\color{red}barbara with lph applied}');
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);
axis tight,axis on;



toc;
