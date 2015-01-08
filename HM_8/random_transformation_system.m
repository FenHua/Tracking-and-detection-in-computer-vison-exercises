function [ original_intensities, warped_intensities, displacement_vector ] = random_transformation_system( img, random_displacement_range, rectangle_top_left_x_y, rectangle_bottom_right_x_y )
    %RANDOM_TRANSFORMATION_SYSTEM Summary of this function goes here
    %   Detailed explanation goes here
    
    
    random_displacement_range = [-30, 30];
    x_y_random_value_length = random_displacement_range(2) - random_displacement_range(1);
    
    rectangle_top_right_x_y = [rectangle_bottom_right_x_y(1), rectangle_top_left_x_y(2)];
    rectangle_bottom_left_x_y = [rectangle_top_left_x_y(1), rectangle_bottom_right_x_y(2)];

    rectangle_coords = [rectangle_top_left_x_y; rectangle_top_right_x_y; rectangle_bottom_left_x_y; rectangle_bottom_right_x_y];

    % Show the extracted rectangle
    %rectangle = img(rectangle_top_left_x_y(2):rectangle_bottom_right_x_y(2), rectangle_top_left_x_y(1):rectangle_bottom_right_x_y(1));
    %imshow(rectangle);

    rectangle_random_values = rand(4, 2)* x_y_random_value_length + random_displacement_range(1);

    rectangle_new_coords = rectangle_coords + rectangle_random_values;

    rectangle_coords_homog = [rectangle_coords'; ones(1, size(rectangle_coords, 1))];
    rectangle_new_coords_homog = [rectangle_new_coords'; ones(1, size(rectangle_new_coords, 1))];

    H = DLT(rectangle_coords_homog, rectangle_new_coords_homog);

    x_span = rectangle_top_left_x_y(1):5:rectangle_top_right_x_y(1);
    y_span = rectangle_top_right_x_y(2):5:rectangle_bottom_right_x_y(2);

    [x, y] = meshgrid(x_span, y_span);

    grid_coords = [x(:) y(:)];

    grid_coords = [ grid_coords'; ones(1, size(grid_coords, 1))];

    back_warp_coords = inv(H)*grid_coords;

    back_warp_coords = back_warp_coords ./ repmat( back_warp_coords(3,:), 3, 1 );
    
    amount_of_grid_elements = numel(x);

    original_intensities = zeros(amount_of_grid_elements, 1);
    warped_intensities = zeros(amount_of_grid_elements, 1);

    for coordinate_number = 1:amount_of_grid_elements

        original_intensities(coordinate_number) =  img(round(grid_coords(2, coordinate_number)), round(grid_coords(1, coordinate_number)));
        warped_intensities(coordinate_number) =  img(round(back_warp_coords(2, coordinate_number)), round(back_warp_coords(1, coordinate_number)));
    end

    displacement_vector = reshape(rectangle_random_values, [], 1);

end

