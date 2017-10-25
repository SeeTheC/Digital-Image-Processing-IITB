% Guassian Lowpass filter. Take 2 parameter
% # Filter Size
% # cutoff Frequency
function H=gaussianLowPass(dim,cutOffFreq)
    row=dim(1);col=dim(2);
    H=zeros(row,col);
    D=cutOffFreq^2;
    ui=ceil(row/2);vi=ceil(col/2);
    for u=1:row
        for v=1:col
            H(u,v)=exp(-1*((u-ui)^2 + (v-vi)^2)/(2*D) );
        end
    end
end
