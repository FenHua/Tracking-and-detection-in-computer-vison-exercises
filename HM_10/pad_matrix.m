function [ result ] = pad_matrix( matrix, bottom_top_padding, side_padding, mode )
    %   PADD_MATRIX Creates a new matrix with padding on the borders.
    %   It is used before applying a convolution or correlation to a
    %   matrix. Has two options of padding: symmetric, where new values in
    %   the padding area a symmetricly taken from the original matrix.
    %   Replicate, where the values are taken only from the border of the
    %   original matrix.
    %   Input:
    %   @matrix - original matrix to add padding to.
    %   @bottom_top_padding - amount of new rows to add on the top and 
    %   at the bottom.
    %   @side_padding - amount of columns to add from the sides.
    %   @mode - selected padding mode. Read description of the function.
    %   Output:
    %   @result - padded matrix. Size: (rows + bottom_top_padding*2, columns + side_padding) 
    
    [row_amount, column_amount] = size( matrix );
    
    if strcmp('symmetric', mode)
        result = [flipud(matrix(1:bottom_top_padding, :)); matrix; flipud(matrix(row_amount-bottom_top_padding:row_amount, :))];
        result = [flipud(result(:, 1:side_padding)')', result, flipud(result(:, column_amount-side_padding:column_amount)')'];
    end
    
    if strcmp('replicate', mode)
       result = [repmat(matrix(1, :), [bottom_top_padding, 1]); matrix; repmat(matrix(row_amount, :), [bottom_top_padding, 1])];
       result = [repmat(result(:, 1), [1, side_padding]), result, repmat(result(:, column_amount), [1, side_padding])];
    end
    
    
end

