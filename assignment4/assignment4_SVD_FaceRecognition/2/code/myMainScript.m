%% Eigen Faces

%% Initializing: Yale Datase
yaleDirpath='../../data/CroppedYale';
[yaleTrainImgCell,yaleTestImgCell]=readData(yaleDirpath,'yale');
fprintf('Reading of images Done.\n');
row=192;col=168;
%% Finding the EignFace : Yale Dateset
tic
trainImgCell=yaleTrainImgCell;
[xMean,efaceNormalized,devTrainImg]=eigenFaceUsingSVD(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');
toc
%% Reconstruction of Image
% Reconstructing 3nd Yale Person i.e (yaleB03), first pos, 
tic
person=3; 
devTrainVector=devTrainImg(:,person);
k=[2, 10,20, 50, 75, 100, 125, 150, 175];
for i=1:numel(k)
    Vk=efaceNormalized(:,1:k(i));   
    eigenCoffs=Vk'*devTrainVector; 
    % Re_Img=average face + (a1*eigenface 1) + (a2 * eigenface 2) + (a3 *
    % eigenface 3) ....
    reconstructedImg=xMean+(Vk*eigenCoffs);
    figure('name',strcat('Reconstructed Image with K:',int2str(k(i))));    
    eigFaceImage = reshape(reconstructedImg,row,col);    
    colormap(gray);
    imagesc(eigFaceImage);
    title(strcat('\fontsize{12}{\color{magenta}Reconstructed Image with K:',int2str(k(i)),'}'));
    colorbar;
end
toc
pause(3);
%% First 25 Largest Eigen Faces
tic
for i=1:25
    figure('name',strcat('Eigen Face:',int2str(i)));
    testEigFace=efaceNormalized(:,i);
    eigFaceImage = reshape(testEigFace,row,col);    
    colormap(gray);
    imagesc(eigFaceImage);
    title(strcat('\fontsize{10}{\color{magenta}Eigen Face: ',int2str(i),'}'));
    colorbar;
end
toc;
