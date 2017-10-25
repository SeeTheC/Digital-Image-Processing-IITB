% Ideal Lowpass filter. Take 2 parameter
% # Filter Size
% # cutoff Frequency
function H=idealLowpass(dim,cutOffFreq)
    row=dim(1);col=dim(2);
    H=zeros(row,col);
    ui=ceil(row/2);vi=ceil(col/2);
    radiusSq=cutOffFreq^2;
    for u=1:row
        for v=1:col
            if (u-ui)^2 + (v-vi)^2 <= radiusSq
                H(u,v)=1;
            end
        end
    end  
end
