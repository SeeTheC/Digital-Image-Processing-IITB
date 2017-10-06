function recognitionRate = imageRecognition(eigFace,xMean,devTrainCell,testCell,ks)
    recognitionRate={};
    %Tries to recognise the test image with K eigen Values    
    devTestSet=bsxfun(@minus, testCell{1}, xMean);
    successRate=zeros(1,numel(ks));    
    for i=1:numel(ks)        
        successRate(i)=recognise(eigFace,ks(i),devTrainCell,{devTestSet,testCell{2}});
        fprintf('K=%d\tRecognition-Rate:%f \n',ks(i),successRate(i));
    end
    recognitionRate{1}=ks;
    recognitionRate{2}=successRate;
end


function successRate = recognise(V,k,devTrainCell,devTestCell)
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
    
    for i=1:n
        bCoff_i=bEigenCoff(:,i);
        % j= || aj-b||2
        alphaMinusBeta=bsxfun(@minus, aEigenCoff, bCoff_i);
        alphaMinusBetaSq=alphaMinusBeta.^2;
        alphaMinusBetaNorm=sum(alphaMinusBetaSq);
        % Recognisation: j= min || aj-b||2  for j in the train set       
        [error,index]=min(alphaMinusBetaNorm);        
        %fprintf('testImg_%d : %d\n',i,index);
        if(trainLabel(index)==testLabel(i))
            correctRecognition=correctRecognition+1;
        end
    end
    successRate=correctRecognition/n;
end
