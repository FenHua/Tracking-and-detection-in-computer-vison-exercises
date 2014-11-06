function [ kernel ] = laplacian_2d_kernel( deviation )
 %GAUSSIAN_2D_KERNEL Returns normalized kernel with the size 3*deviation
    % case of odd deviation and (3*deviation+1) for an even deviation. This
    % is due to symmetric properties of gaussian
    % Input:
    % @deviation - standart deviation for the gaussian function.
    % Output:
    % @kernel - kernel approximation of gaussian filter with the size
    % 3*deviation or (3*deviation+1)
   
    size = 3*deviation;
    one_side = floor(size/2);
    interval = -one_side:one_side;

    [X, Y] = meshgrid(interval, interval);

    kernel = -1/(pi*deviation^4)*(1 - (X.^2 + Y.^2)/(2*deviation^2))*exp(-(X.^2 + Y.^2)/(2*deviation^2)); 
    
    % Normalization of a kernel
    kernel = kernel /(sum(kernel(:)));

end