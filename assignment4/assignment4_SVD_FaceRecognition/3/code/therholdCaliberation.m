function recognitionRate = therholdCaliberation(eigFace,xMean,devTrainCell,testCell,noOfPerson,ks)
    recognitionRate={};
    %Tries to recognise the test image with K eigen Values    
    devTestSet=bsxfun(@minus, testCell{1}, xMean);
    successRate=zeros(1,numel(ks));
    error=zeros(numel(ks),size(devTestSet,2));
    therhold=zeros(numel(ks),noOfPerson);
    for i=1:numel(ks)        
        [successRate(i),e,tk]=recognise(eigFace,ks(i),devTrainCell,{devTestSet,testCell{2}},noOfPerson);
        %fprintf('K=%d\tRecognition-Rate:%f \n',ks(i),successRate(i));
        error(i,:)=e;  
        therhold(i,:)=tk;
    end
    recognitionRate{1}=ks;
    recognitionRate{2}=successRate;
    recognitionRate{3}=therhold;
    recognitionRate{4}=error;
end


function [successRate,error,thersold] = recognise(V,k,devTrainCell,devTestCell,noOfPerson)
    %Tries to recognise the test image with K eigen Values
    %taking K largest Eigen vector
    Vk=V(:,1:k);
    VkT=Vk';
    % eigenCoff: kxnumber_of_img 
    aEigenCoff=VkT*devTrainCell{1};
    bEigenCoff=VkT*devTestCell{1};
    n=size(devTestCell{1},2);
    %Label Fetch
    trainLabel=devTrainCell{2};
    testLabel=devTestCell{2};  
    correctRecognition=0;
    e=[];
    thersold=zeros(noOfPerson,1);
    thersold(:)=-Inf;
    for i=1:n
        bCoff_i=bEigenCoff(:,i);
        % j= || aj-b||2
        alphaMinusBeta=bsxfun(@minus, aEigenCoff, bCoff_i);
        alphaMinusBetaSq=alphaMinusBeta.^2;
        alphaMinusBetaNorm=sum(alphaMinusBetaSq);
        % Recognisation: j= min || aj-b||2  for j in the train set       
        [error,index]=min(alphaMinusBetaNorm);        
        %fprintf('testImg_%d : %d error:%f\n',i,index,sqrt(error));
        if(trainLabel(index)==testLabel(i))
            correctRecognition=correctRecognition+1;
            error=sqrt(error);             
            thersold(testLabel(i))=max(thersold(testLabel(i)),error);
        else 
            error=-Inf;
        end        
        e=[e,error];
    end
    error=sort(e,'descend');
    successRate=correctRecognition/n;
end
