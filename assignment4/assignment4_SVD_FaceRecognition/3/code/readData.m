function [trainImgMatrix,testImgMatrix] = readData(dirpath)
   dim=[112,92];
   totalPerson=40;
   trainPerson=32;
   perPersonTrain=6; % Only for intial 1st to 32nd persons
   perPersonTest=4; % Only for intial 1st to 32nd persons  
   [trainImgMatrix,testImgMatrix]=readDB(dirpath,dim,totalPerson,trainPerson,perPersonTrain,perPersonTest);    
end

% Reads the images from the Database and returns the trainImage dataset and
% test image data set.
function [trainImgCell,testImgCell]=readDB(dirpath,dimension,totalPerson,numOfPerson,trainSize,testSize)
    row=dimension(1);col=dimension(2);
    % Train  martix Init
    % Total TrainImage: (perPersonTrain*trainPerson) 
    noOfTrainImage=(numOfPerson*trainSize);   
    trainImgMatrix=zeros(row*col,noOfTrainImage);
    trainImgLabel=zeros(noOfTrainImage,1);
    
    % Test  martix Init
    % Total TestImage: (perrPersonTest*trainPerson) + (10*totalPerson)
    % i.e (4*32) + (10*8)
    noOfTestImage=(numOfPerson*testSize) + (10*(totalPerson-numOfPerson));
    testImgMatrix=zeros(row*col,noOfTestImage);   
    testImgLabel=zeros(noOfTestImage,1);
    
    imgFolderPerPerson = dir(dirpath);
    imgFolderPerPerson=natsortfiles({imgFolderPerPerson.name}); 
    personCount=0;            
    
    for i= 1:numel(imgFolderPerPerson);  
            folderName=imgFolderPerPerson(i);folderName=folderName{1};
            if ( strcmp( folderName,'.') || strcmp(folderName,'..') || strcmp(folderName,'README'))
                continue;
            end
            if personCount>= totalPerson 
                break;
            end
            
            
            imgDirPerPerson=strcat(dirpath,'/',folderName);
            imgFilesPerPerson = dir(imgDirPerPerson);            
            perPersonCount=1;
            %fprintf('-----------[%s]-------------\n',folderName);
            for j = 1:numel(imgFilesPerPerson)
                    %fileName=imgFilesPerPerson(j);fileName=fileName{1};
                    fileName=imgFilesPerPerson(j).name;
                    if ( strcmp(fileName,'.') || strcmp(fileName,'..'))
                        continue;
                    end 
                    fullFilePath=strcat(imgDirPerPerson,'/',fileName);
                    %fprintf('%s:\n',fullFilePath);
                    img = imread(fullFilePath);
                    [irow,icol] = size(img);
                    vector = reshape(img,irow*icol,1);
                    if personCount < numOfPerson 
                            if perPersonCount <= trainSize
                                k=(personCount*trainSize)+perPersonCount;
                                trainImgMatrix(:,k) = vector;
                                trainImgLabel(k)=personCount+1;
                            else
                                k=(personCount*testSize)+perPersonCount-trainSize;
                                testImgMatrix(:,k) = vector;
                                testImgLabel(k)=personCount+1;
                            end
                    else
                            k=(numOfPerson*testSize)+((personCount-numOfPerson)*10)+perPersonCount;
                            testImgMatrix(:,k) = vector;
                            testImgLabel(k)=personCount+1;
                    end                                
                    perPersonCount=perPersonCount+1;
            end
            personCount=personCount+1;
    end 
    trainImgCell={trainImgMatrix,trainImgLabel};
    testImgCell={testImgMatrix,testImgLabel};
    
end

            