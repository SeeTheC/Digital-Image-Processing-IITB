function H=lowpass(absfimg,cutOffFreq)
    [row,col]=size(absfimg);
    H=zeros(row,col);
    for u=1:row
        for v=1:col
            if (u-row/2)^2 + (v-col/2)^2 <= (cutOffFreq^2)
                H(u,v)=1;
            end
        end
    end
    H(row/2-1,col/2-1)=1;
    H(row/2,col/2-1)=1;
    H(row/2-1,col/2)=1;
    H(row/2+1,col/2)=1;
    H(row/2,col/2+1)=1;
    H(row/2+1,col/2+1)=1;
    H(row/2,col/2)=1;
    H(row/2-1,col/2+1)=1;
    H(row/2+1,col/2-1)=1;

end