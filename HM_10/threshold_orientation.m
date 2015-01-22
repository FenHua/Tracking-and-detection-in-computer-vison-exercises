function [ result ] = threshold_orientation( img_orig, threshold )
    %THRESHOLD_ORIENTATION Summary of this function goes here
    %   Detailed explanation goes here
    
    Gradient_x = [-1 0 1; -1 0 1; -1 0 1];
    Gradient_y = [-1 -1 -1; 0 0 0; 1 1 1];
    
    
    magnitudes_bands = zeros(size(img_orig));
    orientation_bands = zeros(size(img_orig));
    
    
    for band_number = 1:3
        
        result_x_gradient = convolution(img_orig(:, :, band_number), Gradient_x, 'symmetric');
        result_y_gradient = convolution(img_orig(:, :, band_number), Gradient_y, 'symmetric');
    
        Magnitude = (result_x_gradient).^2+(result_y_gradient.^2);
        Magnitude = Magnitude.^1/2;
        
        Orientation = atan(double(result_y_gradient./result_x_gradient));
        
        magnitudes_bands(:, :, band_number) = Magnitude;
        orientation_bands(:, :, band_number) = Orientation;
    end
    
    [max_magn_values, max_magn_indexes] = max(magnitudes_bands, [], 3);
    
    
    max_orientation_values = zeros(size(orientation_bands, 1), size(orientation_bands, 2));
    
    for row = 1:size(orientation_bands, 1)
        for col = 1:size(orientation_bands, 2)
            
            max_orientation_values(row, col) = orientation_bands(row, col, max_magn_indexes(row, col) );
        end
    end
    
    max_orientation_values(max_magn_values <= threshold) = NaN;
    
    result = max_orientation_values;
    

end

