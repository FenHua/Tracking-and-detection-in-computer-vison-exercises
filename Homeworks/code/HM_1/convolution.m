function [ convoluted_matrix ] = convolution( input_matrix, kernel, border_treatment_mode )
    % CONVOLUTION Applies convolution to a specified matrix
    % Input:
    % @input_matrix - input matrix to be convoluted
    % @kernel - kernel matrix to applied to @input_matrix
    % @border_treatment_mode - if kernel doesn't fit into matrix, matrix is
    % extended using one of available modes: symmetric or replicate. You
    % can more about them in the specification of a pad_matrix function.
    % Output:
    % 

    [Image_x, Image_y, ~] = size(input_matrix);
    [Kernel_x, Kernel_y,~] = size(kernel);

    pad_x = floor(Kernel_x/2);
    pad_y = floor(Kernel_y/2);

    % Rotation of a kernel on 180 degrees
    temp_Kernel = flipud(kernel);
    kernel = double(flipud(temp_Kernel')');

    convoluted_matrix  = zeros(Image_x,Image_y, 'double');

    padded_matrix = pad_matrix(input_matrix,pad_x,pad_y,border_treatment_mode);

    for x = 1:Image_x
        for y = 1:Image_y
            frame = double( padded_matrix(x:x+(2*pad_x),y:y+(2*pad_y)) );   
            convoluted_matrix(x,y) = kernel(:)'*frame(:);

        end
    end

end

