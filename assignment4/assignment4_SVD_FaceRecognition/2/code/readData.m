function [trainImgMatrix,testImgMatrix] = readData(dirpath,dbType)
    if strcmp(dbType,'att_faces')
        dim=[112,92];
        [trainImgMatrix,testImgMatrix]=readDB(dirpath,dim,32,6,4);
    end
    if strcmp(dbType,'yale')
        dim=[192,168];
        [trainImgMatrix,testImgMatrix]=readDB(dirpath,dim,38,40,20);
    end
end

% Reads the images from the Database and returns the trainImage dataset and
% test image data set.
function [trainImgCell,testImgCell]=readDB(dirpath,dimension,numOfPerson,trainSize,testSize)
    row=dimension(1);col=dimension(2);
    trainImgMatrix=zeros(row*col,numOfPerson*trainSize);
    trainImgLabel=zeros(numOfPerson*trainSize,1);
    testImgMatrix=zeros(row*col,numOfPerson*testSize);   
    testImgLabel=zeros(numOfPerson*testSize,1);
    imgFolderPerPerson = dir(dirpath);
    imgFolderPerPerson=natsortfiles({imgFolderPerPerson.name}); 
    personCount=0;            
    for i= 1:numel(imgFolderPerPerson);  
            folderName=imgFolderPerPerson(i);folderName=folderName{1};
            if ( strcmp( folderName,'.') || strcmp(folderName,'..') || strcmp(folderName,'README'))
                continue;
            end
            if personCount>=numOfPerson 
                break;
            end
            
            imgDirPerPerson=strcat(dirpath,'/',folderName);
            imgFilesPerPerson = dir(imgDirPerPerson);
            %imgFilesPerPerson=natsortfiles({imgFilesPerPerson.name});     
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
                    if perPersonCount <= trainSize
                        trainImgMatrix(:,(personCount*trainSize)+perPersonCount) = vector;
                        trainImgLabel((personCount*trainSize)+perPersonCount)=personCount+1;
                    else
                        testImgMatrix(:,(personCount*testSize)+perPersonCount-trainSize) = vector;
                        testImgLabel((personCount*testSize)+perPersonCount-trainSize)=personCount+1;
                    end
                    perPersonCount=perPersonCount+1;
            end
            personCount=personCount+1;
    end 
    trainImgCell={trainImgMatrix,trainImgLabel};
    testImgCell={testImgMatrix,testImgLabel};
    
end

            