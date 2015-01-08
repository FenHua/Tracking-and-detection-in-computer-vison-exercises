function [ resulted_matrix ] = gaussian_noise( matrix, deviation )
    %GAUSSIAN_NOISE Summary of this function goes here
    %   Detailed explanation goes here
    
    noise = normrnd(0, deviation, size(matrix));
    
    resulted_matrix = double(matrix) + noise;
    

end

