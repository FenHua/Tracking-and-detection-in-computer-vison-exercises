
img = rgb2gray( imread('images/0000.png') );

x_y_random_value_range = [-30, 30];
rectangle_top_left_x_y = [103, 76];
rectangle_bottom_right_x_y = [552, 383];

% random transformation function example
[ original_intensities, warped_intensities, displacement_vector ] = random_transformation_system( img, x_y_random_value_range, rectangle_top_left_x_y, rectangle_bottom_right_x_y );

A = learning( img, x_y_random_value_range, rectangle_top_left_x_y, rectangle_bottom_right_x_y );