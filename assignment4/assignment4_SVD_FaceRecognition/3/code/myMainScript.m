%% Face recognition using Eigen Faces
%Face recognition using Eigen Faces and also handling thoes faces of person which are
%not in the dataset

%% 1. Calibration of the Thershold
% We are finding thershold specific to the Label i.e Person in the dataset
% by divinding the train data into two parts.
% 
% * Train Set of Size: 4*32 = 128
% * Validate Set of Size: 2*32 = 64
% 

%% Global Constant
attDirpath='../../data/att_faces';
dim=[112,92];
%% Initialization Att Face Datase
% Validate images will be used for caliberating the Thresholde value
totalPerson=40;trainPerson=32;
% Only for intial 1st to 32nd persons
perPersonTrain=4; perPersonVal=2; perPersonTest=4; 

[attrTrainImgCell,attrValImgCell,attrTestImgCell]=readData(attDirpath,dim,totalPerson,trainPerson,perPersonTrain,perPersonVal,perPersonTest);    

fprintf('# of Train image 4*32 = 128\n');
fprintf('# of Validate image 2*32 = 64\n');
fprintf('# of Test image 4*32 + 80 = 208\n');

%% Finding the EignFace
tic
trainImgCell=attrTrainImgCell;
[xMean,efaceNormalized,devTrainSet]=eigenFace(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');

toc

%% Testing The Validate image Image and Caliberation of Threshold
tic
testImgCell=attrValImgCell;
ks=[1:127];
%ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 120];
recognitionRate=therholdCaliberation(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,trainPerson,ks);
thershold=recognitionRate{3};
fprintf('Recognising Validate data and Calibarting Thershold.Done.\n');
toc


%% Recognition Plot: For Validatation Set
%Drawing Plot
figure('name','Recognition Plot: Validatation Set');
x=recognitionRate{1};
y=recognitionRate{2};
plot(x,y);
xlabel('K');ylabel('Rate');
title('\fontsize{12}{\color{magenta}Recognition Plot: Validatation Set}');

%% 2. Testing on Testing data

%% Initialization Att Face Datase
totalPerson=40;trainPerson=32;
perPersonTrain=6; perPersonVal=0; perPersonTest=4; 
[attrTrainImgCell,attrValImgCell,attrTestImgCell]=readData(attDirpath,dim,totalPerson,trainPerson,perPersonTrain,perPersonVal,perPersonTest);    
% Finding the EignFace
tic
trainImgCell=attrTrainImgCell;
[xMean,efaceNormalized,devTrainSet]=eigenFace(trainImgCell{1});
fprintf('Finding Eigen Faces.Done.\n');
toc


%% Testing on Test data
tic
testImgCell=attrTestImgCell;
%t=testImgCell{1};
%ks=[1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 120];
%ks=[1:128];
%testImgCell{1}=t(:,1:128);
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,thershold,ks);
fprintf('Recognising Test data.Done.\n');
toc


%% Recognition Plot: Attr_Face DataSet
%Drawing Plot
figure('name','Recognition Plot: Test Set');
x=recognitionRate{1};
y=recognitionRate{2};
plot(x,y);
xlim([0,128]);xlabel('K');ylim([0,1]);ylabel('Rate');
title('\fontsize{12}{\color{magenta}Recognition Plot: Test Set}');


% False Negative
figure('name','False Negative Plot: Test Set');
x=recognitionRate{1};
y=recognitionRate{3};
plot(x,y);
xlim([0,128]);xlabel('K');ylim([0,1]);ylabel('Rate');
title('\fontsize{12}{\color{magenta}False Negative Plot: Test Set}');


% False Positive
figure('name','False Positive Plot: Test Set');
x=recognitionRate{1};
y=recognitionRate{4};
plot(x,y);
xlim([0,128]);xlabel('K');ylim([0,1]);ylabel('Rate');
title('\fontsize{12}{\color{magenta}False Positive Plot: Test Set}');

%%