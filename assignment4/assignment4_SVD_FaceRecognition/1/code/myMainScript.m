%% Eace recognition using Eigen Faces

tic;
%% Initialization
attDirpath='../data/att_faces';
yaleDirpath='../data/CroppedYale';
[attrTrainImgCell,attrTestImgCell]=readData(attDirpath,'att_faces');
[yaleTrainImgCell,yaleTestImgCell]=readData(yaleDirpath,'yale');
fprintf('Reading of images Done.\n');
%% 1. Attr_Face DataSet
%% Finding the EignFace : Attr_Face DataSet
tic
trainImgCell=attrTrainImgCell;
testImgCell=attrTestImgCell;
[xMean,efaceNormalized,devTrainSet]=eigenFace(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');
toc
%% Testing The Probe Image : Attr_Face DataSet
tic
ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];   
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

%% 2. Yale DataSet
%% Finding the EignFace : Yale Dateset
tic
trainImgCell=yaleTrainImgCell;
testImgCell=yaleTestImgCell;
[xMean,efaceNormalized,devTrainSet]=eigenFace(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');
toc
%% Testing The Probe Image : Yale Dateset
tic
ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,ks);
fprintf('Recognising Test data.Done.\n');
toc
%% Recognition Plot: Yale Dateset
%Drawing Plot
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
%Drawing Plot
figure('name','Recognition Plot: Yale DataSet- Illumination Change');
x=recognitionRate{1};
y=recognitionRate{2};
plot(x,y,'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);
title('\fontsize{12}{\color{magenta}Recognition Plot: Yale DataSet By removing TOP 3 Eign faces}');


%% TEST CODE: DONOT DELETE
%{
%person=1;ts=6;tts=4;row=112;col=92;
%person=1;ts=40;tts=20;row=192;col=168;
trainImgMatrix=trainImgCell{1};
testImgMatrix=testImgCell{1};
v=trainImgMatrix(:,(person)*ts-(ts-1));
rv=reshape(v,row,col);
colormap(gray);
imagesc(rv);

figure;
v=testImgMatrix(:,(person)*tts-(tts-1));
rv=reshape(v,row,col);
colormap(gray);
imagesc(rv);
%}
%% TEST CODE: DONOT DELETE
%{
figure
testEigFace=efaceNormalized(:,40);
eigFaceImage = reshape(testEigFace,row,col);
colormap(gray);
imagesc(eigFaceImage);
colorbar;
toc;
%}