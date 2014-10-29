function [ filtered_matrix ] = median_filter( input_matrix, kernel_size, border_treatment_mode )
    % Applies median filter to input matrix
    % Input:
    % @input_matrix - input matrix to be filtered
    % @kernel_size - kernel size to use
    % @border_treatment_mode - if kernel doesn't fit into matrix, matrix is
    % extended using one of available modes: symmetric or replicate. You
    % can more about them in the specification of a pad_matrix function.
    % Output:
    % @filtered_matrix - resulted matrix

    [Image_x, Image_y, ~] = size(input_matrix);
    Kernel_x = kernel_size(1);
    Kernel_y = kernel_size(2);

    pad_x = floor(Kernel_x/2);
    pad_y = floor(Kernel_y/2);

    filtered_matrix  = zeros(Image_x, Image_y);

    padded_matrix = pad_matrix(input_matrix,pad_x,pad_y,border_treatment_mode);

    for x = 1:Image_x
        for y = 1:Image_y
            frame = padded_matrix(x:x+(2*pad_x),y:y+(2*pad_y));
            sorted_list_of_values = sort(frame(:));
            median_index = ceil( size(sorted_list_of_values, 1)/2 );
            median_value = sorted_list_of_values(median_index);
            filtered_matrix(x,y) = median_value;

        end
    end

end


