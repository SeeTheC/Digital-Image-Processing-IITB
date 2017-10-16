function H=notchFilter(dim,center,radius)
    row=dim(1);col=dim(2);    
    H=ones(row,col);
    for u=1:row
        for v=1:col
            for i=1:size(center,2);
                ui=center{i}(1);vi=center{i}(2);
                distance=(u-ui)^2 + (v-vi)^2;
                val=1-exp( -1*(distance/radius^2) );
                %if  distance <= radius^2
                %    notchFilter(u,v)=0;
                %end
                H(u,v)=H(u,v)*val;
            end
        end
    end
end