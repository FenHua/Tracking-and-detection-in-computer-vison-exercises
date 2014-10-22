function [ kernel ] = gaussian_1d_kernel( deviation, mode )
    %GAUSSIAN_1D_KERNEL Returns normalized kernel of 1d gaussian distribution 
    % with the size 3*deviation case of odd deviation and (3*deviation+1) 
    % for an even deviation. This is due to symmetric properties of gaussian
    % Input:
    % @deviation - standart deviation for the gaussian function.
    % Output:
    % @kernel - kernel approximation of gaussian filter with the size
    % 3*deviation or (3*deviation+1)
    
    size = 3*deviation;
    one_side = floor(size/2);
    interval = -one_side:one_side;
    
    if strcmp(mode, 'horizontal')
        grid = interval;
    end
    
    if strcmp(mode, 'vertical')
        grid = interval';
    end
    
    kernel = (1\(2*pi*deviation^2))*exp(-0.5*(grid.^2)/(deviation^2));
    
    % Normalization of a kernel
    kernel = kernel /(sum(kernel(:)));


end

