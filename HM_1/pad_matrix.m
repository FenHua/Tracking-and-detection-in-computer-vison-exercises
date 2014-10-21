function [ result ] = padd_matrix( matrix, bottom_top_padding, side_padding, mode )
%   PADD_MATRIX Summary of this function goes her
%   Detailed explanation goes here
    
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

