function feature_points  = Harris_Laplace( img, s0, k, alpha, threshold_h, threshold_l, resolution_levels)
    
    % Laplacian
    laplace_kernel = [[0 1 0]; [1 -4 1]; [0 1 0]];

    [x_size, y_size] = size(img);
    harris_scales_levels = zeros(x_size, y_size, resolution_levels);
    interest_points = zeros(x_size, y_size, resolution_levels);


    for level = 1:resolution_levels
        % integral deviation
        current_deviation = s0 * k^(level);
        % Simple Harris's descriptor
        current_level_layer = Harris_function(img, level-1, s0, k, alpha);
        % Find max throughout 8 neighbours
        interest_points(:, :, level) = nlfilter(current_level_layer, [3 3], @(x) (x(5) > threshold_h && all(x(5) > x([1:4 6:9]))));
        % Special laplacian for comparing values
        laplacian_kernel = laplacian_2d_kernel(current_deviation);
        harris_scales_levels(:, :, level) = abs(current_deviation^2 * conv2(double(img), laplacian_kernel, 'same'));
    end

    points_of_interest_index = find(interest_points > 0);
    
    % Leave out only local maximum values in a scale space
    for element = 1:size(points_of_interest_index)
        [x, y, z] = ind2sub( size(harris_scales_levels), points_of_interest_index(element));

        if(harris_scales_levels(x, y, z) < threshold_l)
            points_of_interest_index(element) = 0;
        end

        if ((z-1) > 0)
            if(harris_scales_levels(x, y, z-1) >= harris_scales_levels(x, y, z))
                points_of_interest_index(element) = 0;
            end
        end

        if ((z+1) <= resolution_levels)
            if(harris_scales_levels(x, y, z+1) >= harris_scales_levels(x, y, z))
                points_of_interest_index(element) = 0;
            end
        end
    end

    points_of_interest_index = points_of_interest_index(points_of_interest_index > 0);
    
    feature_points = zeros(size(points_of_interest_index, 1), 3);
    
    for i = 1:size(points_of_interest_index, 1)
        [x, y, z] = ind2sub( size(harris_scales_levels), points_of_interest_index(i));
        feature_points(i, 1) = x;
        feature_points(i, 2) = y;
        feature_points(i, 3) = s0 * k^(z);
    end
        
end
