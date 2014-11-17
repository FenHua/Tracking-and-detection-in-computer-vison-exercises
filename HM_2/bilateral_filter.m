function [ filtered_matrix ] = bilateral_filter( input_matrix, distance_deviation, intensity_deviation, border_treatment_mode )
    % Applies bilateral filter to input matrix
    % Input:
    % @input_matrix - input matrix to be filtered
    % @intensity_deviation - deviation parameter for intensity
    % @distance_deviation - deviation parameter for distance. Size of
    % kernel will be 3*deviation.
    % @border_treatment_mode - if kernel doesn't fit into matrix, matrix is
    % extended using one of available modes: symmetric or replicate. You
    % can more about them in the specification of a pad_matrix function.
    % Output:
    % @filtered_matrix - resulted matrix

    [Image_x, Image_y, ~] = size(input_matrix);
    
    % Precompute domain kernel because it will be the same for every pixel
    Kernel_x = 3*distance_deviation;
    Kernel_y = 3*distance_deviation;
    kernel_size = [Kernel_x, Kernel_y];
    
    one_side = floor(Kernel_x/2);
    interval = -one_side:one_side;
    [X, Y] = meshgrid(interval, interval);
    domain_kernel = exp(-0.5*(X.^2 + Y.^2)/(distance_deviation^2));
    
    % Padd image for proper border treatment
    pad_x = floor(Kernel_x/2);
    pad_y = floor(Kernel_y/2);

    filtered_matrix  = zeros(Image_x, Image_y);

    padded_matrix = pad_matrix(input_matrix, pad_x, pad_y, border_treatment_mode);

    for x = 1:Image_x
        for y = 1:Image_y
            frame = double(padded_matrix(x:x+(2*pad_x),y:y+(2*pad_y)));
            original_value = double(input_matrix(x, y));
            original_value_matrix = repmat(original_value, kernel_size);
            range_kernel = exp( -0.5*((original_value_matrix - frame)/intensity_deviation).^2 );
            
            denominator = domain_kernel.*range_kernel;
            numerator = sum(sum(frame.*denominator));
            denominator = sum(sum(denominator));
            
            resulted_value = numerator/denominator;
             
            filtered_matrix(x,y) = resulted_value;

        end
    end

end

