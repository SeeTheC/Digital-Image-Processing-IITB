%% Assignment 4--3
% CS-663
% Group-163059009, 16305R011
%% Mechanism used for the fact there is no matching identity is
% Algo is divided into two parts. 

%%
% 
% # Calibrating threshold  
% # Testing
% 
%
% In Calibrating part
% We are finding thershold specific to the Label i.e Person in the dataset
% by divinding the train data into two parts.There sizes are :
% 
% * Train Set of Size: 4*32 = 128
% * Validate Set of Size: 2*32 = 64
% 
%
% In testing Phase we are recognizing faces and setting the following values : 
%%
% 
% * False Negative
% * False Positive
% * Recognition rate
% 



%% Face recognition using Eigen Faces
% Face recognition using Eigen Faces and also handling thoes faces of person which are
% not in the dataset



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
% Validate images will be used for caliberating the Threshold value
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
% Finding threshold values for every person i.e. 32 person in our db for
% every k wher k is from 1 to 127. It return  s * threshold values an recognition rate on validation set *

tic
testImgCell=attrValImgCell;
ks=[1:127];
recognitionRate=therholdCaliberation(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,trainPerson,ks);
thershold=recognitionRate{3};
fprintf('Recognising Validate data and Calibarting Thershold.Done.\n');
toc


%% Recognition Plot: For Validatation Set
% Drawing Plot
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
recognitionRate=imageRecognition(efaceNormalized,xMean,{devTrainSet,trainImgCell{2}},testImgCell,thershold,ks);
fprintf('Recognising Test data.Done.\n');
toc


%% Recognition Plot: Attr_Face DataSet
% Drawing Plot
% showing result for all values of k
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

%% Showing threshold values
% We are showing 32 threshold values for k = 100
k=100;
for i = 1:32
    fprintf('Label:%d\tthreshold:%f\n',i,thershold(k,i));
end
