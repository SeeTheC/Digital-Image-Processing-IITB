%% Face recognition using Eigen Faces
%Face recognition using Eigen Faces and also handling thoes faces of person which are
%not in the dataset

%% Initialization Att Face Datase
attDirpath='../../data/att_faces';
[attrTrainImgCell,attrTestImgCell]=readData(attDirpath);

%% 1. Attr_Face DataSet
%% Finding the EignFace : Attr_Face DataSet
tic
trainImgCell=attrTrainImgCell;
testImgCell=attrTestImgCell;
[xMean,efaceNormalized,devTrainSet]=eigenFace(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');
t=testImgCell{1};
toc
%% Testing The Probe Image : Attr_Face DataSet
tic
%ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
ks=[1:128];
testImgCell{1}=t(:,1:128);
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,ks);
fprintf('Recognising Test data.Done.\n');
toc
%% Recognition Plot: Attr_Face DataSet
%Drawing Plot
figure('name','Recognition Plot: Attr Face DataSet');
x=recognitionRate{1};
y=recognitionRate{2};
plot(x,y,'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);
title('\fontsize{12}{\color{magenta}Recognition Plot: Attr Face DataSet}');
