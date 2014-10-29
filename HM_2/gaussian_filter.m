function [ result ] = gaussian_filter( input_img, deviation )
    %GAUSSIAN_FILTER Summary of this function goes here
    %   Detailed explanation goes here
    
    kernel = gaussian_2d_kernel(deviation);
    result = convolution(input_img, kernel, 'symmetric');

end

