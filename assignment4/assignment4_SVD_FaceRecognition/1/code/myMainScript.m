%% Assignment 4
% CS-663
% Group-16305R011,163059009

%% Face recognition using Eigen Faces
% We have used PCA algorithm to find eigen faces and for optimization we
% have use L matrix where L = A'A
%% Initialization Att Face Datase
% Reading the att_faces and yale database
% Read data will return train and  test cell. Each cell contains data and
% its associated label.
attDirpath='../../data/att_faces';
yaleDirpath='../../data/CroppedYale';
[attrTrainImgCell,attrTestImgCell]=readData(attDirpath,'att_faces');
[yaleTrainImgCell,yaleTestImgCell]=readData(yaleDirpath,'yale');
fprintf('Reading of images Done.\n');

%% 1. Attr_Face DataSet

%% Finding the EignFace : Attr_Face DataSet
% Size of train data set size is 6*32(192) images and test data size is
% 4*32(128) images.
% Here we are finding eigen faces of att_faces. It returns following : 
% 
% * mean vector
% * normalized eigen faces
% * deviated train set from its mean (Xi-X_mean)
% 

tic
trainImgCell=attrTrainImgCell;
testImgCell=attrTestImgCell;
[xMean,efaceNormalized,devTrainSet]=eigenFace(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');
toc

%% Testing The Probe Image : Attr_Face DataSet
% Image Recognition function takes following parameters 
% 
% * normalized eigen face,
% * mean vector of images
% * deviated train set from its mean and associated train set label
% * test images
% * set of k largest eigen values
%
% Image recognition returns regonition rate i.e. how well test set is recognized w.r.t k

tic
ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];   
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,ks);
fprintf('Recognising Test data.Done.\n');
toc

%% Recognition Plot: Attr_Face DataSet
% Drawing Plot
% Plot shows the recognition rate w.r.t k

figure('name','Recognition Plot: Attr Face DataSet');
x=recognitionRate{1};
y=recognitionRate{2};
plot(x,y,'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);
title('\fontsize{12}{\color{magenta}Recognition Plot: Attr Face DataSet}');


%% 2. Yale DataSet
%% Finding the EignFace : Yale Dateset
% Size of train data set size is 40*38 images and test data size is
% 20*38 images.
% Here we are finding eigen faces of Yale Dataset. EigenFace is calculated using SVD. It returns following : 
% 
% * mean vector
% * normalized eigen faces
% * deviated train set from its mean (Xi-X_mean)
% 

tic
trainImgCell=yaleTrainImgCell;
testImgCell=yaleTestImgCell;
[xMean,efaceNormalized,devTrainSet]=eigenFaceUsingSVD(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');
toc

%% Testing The Probe Image : Yale Dateset
% Image Recognition function takes following parameters 
% 
% * normalized eigen face,
% * mean vector of images
% * deviated train set from its mean and associated train set label
% * test images
% * set of k largest eigen values
%
% Image recognition returns regonition rate i.e. how well test set is recognized w.r.t k


tic
ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,ks);
fprintf('Recognising Test data.Done.\n');
toc

%% Recognition Plot: Yale Dateset
% Drawing Plot
figure('name','Recognition Plot: Attr Face DataSet');
x=recognitionRate{1};
y=recognitionRate{2};
plot(x,y,'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);
title('\fontsize{12}{\color{magenta}Recognition Plot: Yale DataSet}');

%% 3. Yale DataSet - Handling Illumination Change
%% Testing The Probe Image : Yale Dateset
% Removing the Top 3 eign vector for handling illumination change on
% dataset
tic
efaceNormalized=efaceNormalized(:,4:size(efaceNormalized,2));
ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,ks);
fprintf('Recognising Test data.Done.\n');
toc

%% Recognition Plot: Yale Dateset
% Drawing Plot when first 3 eigen values are removed and then taking the K values from that.

figure('name','Recognition Plot: Yale DataSet- Illumination Change');
x=recognitionRate{1};
y=recognitionRate{2};
plot(x,y,'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);
title('\fontsize{12}{\color{magenta}Recognition Plot: Yale DataSet By removing TOP 3 Eign faces}');
