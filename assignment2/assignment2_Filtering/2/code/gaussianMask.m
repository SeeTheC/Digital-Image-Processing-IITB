function mat = gaussianMask( dim, sigma, center )
    %GAUSSAINMASK     
    [R,C] = ndgrid(1:dim, 1:dim);
    mat = gaussianVal(R,C, sigma, center);
end

function val = gaussianVal(x, y, sigma, center)
    xc = center(1);
    yc = center(2);
    exponent = ((x-xc).^2 + (y-yc).^2)./(2*sigma^2);
    amplitude = 1 / (sigma * sqrt(2*pi));  
    val = amplitude * exp(-exponent);
end
