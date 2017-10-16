function H=notchFilter(absfimg,R1)
    [row,col]=size(absfimg);
    H=ones(row,col);
    for u=1:row
        for v=1:col
            if absfimg(u,v) <= R1 
                H(u,v)=0;
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