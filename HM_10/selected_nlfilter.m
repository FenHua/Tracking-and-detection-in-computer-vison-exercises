function [ results ] = selected_nlfilter( input_matrix, coords, func_handler, sliding_window_size, border_treatment_mode )
    % CONVOLUTION Applies convolution to a specified matrix
    % Input:
    % @input_matrix - input matrix to be convoluted
    % @kernel - kernel matrix to applied to @input_matrix
    % @border_treatment_mode - if kernel doesn't fit into matrix, matrix is
    % extended using one of available modes: symmetric or replicate. You
    % can more about them in the specification of a pad_matrix function.
    % Output:

    
    
    Kernel_x = sliding_window_size(1);
    Kernel_y = sliding_window_size(2);

    pad_row = floor(Kernel_x/2);
    pad_col = floor(Kernel_y/2);
    
    padded_matrix = pad_matrix(input_matrix, pad_row, pad_col, border_treatment_mode);

    results  = zeros(size(coords, 1), 1, 'double');
    
    amount_of_coords = size(coords, 1);
    
    for coord_count = 1:amount_of_coords
        
        row = coords(coord_count, 1);
        col = coords(coord_count, 2);
        
        frame = padded_matrix(row:row+(2*pad_row),col:col+(2*pad_col));
        size(frame);
        sliding_window_size;
        results(coord_count) = func_handler(frame);
        
    end
end

