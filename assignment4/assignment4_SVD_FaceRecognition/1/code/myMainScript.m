%% Eace recognition using Eigen Faces

tic;
%% Initialization
attDirpath='../data/att_faces';
yaleDirpath='../data/CroppedYale';
[trainImgCell,testImgCell]=readData(attDirpath,'att_faces');
%[trainImgCell,testImgCell]=readData(yaleDirpath,'yale');
fprintf('Reading of images Done.\n');
%% TEST CODE: DONOT DELETE
%person=1;ts=6;tts=4;
%v=trainImgMatrix(:,(person)*ts-(ts-1));
%rv=reshape(v,112,92);
%colormap(gray);
%imagesc(rv);

%figure;
%v=testImgMatrix(:,(person)*tts-(tts-1));
%rv=reshape(v,112,92);
%colormap(gray);
%imagesc(rv);
%% Finding the EignFace : Attr_Face DataSet
tic
[xMean,eigFace,efaceNormalized,devTrainSet]=eigenFace(trainImgCell{1});
toc
%% Testing The Probe Image : Attr_Face DataSet
tic
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell);
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
title('\fontsize{15}{\color{magenta}Recognition Plot: Attr Face DataSet}');

%% TEST CODE: DONOT DELETE
%figure
%testEigFace=efaceNormalized(:,10);
%eigFaceImage = reshape(testEigFace,112,92);
%colormap(gray);
%imagesc(eigFaceImage);
%colorbar;
%toc;
