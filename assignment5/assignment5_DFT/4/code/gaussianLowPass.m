function H=gaussianLowPass(absfimg,cutOffFreq)
    [row,col]=size(absfimg);
    H=zeros(row,col);
    D=cutOffFreq^2;
    for u=1:row
        for v=1:col
            H(u,v)=exp(-(((u-row/2)^2) + ((v-col/2)^2))/2*D);
        end
    end
%     H(row/2-1,col/2-1)=1;
%     H(row/2,col/2-1)=1;
%     H(row/2-1,col/2)=1;
%     H(row/2+1,col/2)=1;
%     H(row/2,col/2+1)=1;
%     H(row/2+1,col/2+1)=1;
%     H(row/2,col/2)=1;
%     H(row/2-1,col/2+1)=1;
%     H(row/2+1,col/2-1)=1;
end