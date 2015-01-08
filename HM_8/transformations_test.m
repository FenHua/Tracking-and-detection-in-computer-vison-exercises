
img = rgb2gray( imread('images/0000.png') );

x_y_random_value_range = [-30, 30];
x_y_random_value_length = x_y_random_value_range(2) - x_y_random_value_range(1);

rectangle_top_left_x_y = [103, 76];
rectangle_bottom_right_x_y = [552, 383];
rectangle_top_right_x_y = [rectangle_bottom_right_x_y(1), rectangle_top_left_x_y(2)];
rectangle_bottom_left_x_y = [rectangle_top_left_x_y(1), rectangle_bottom_right_x_y(2)];

rectangle_coords = [rectangle_top_left_x_y; rectangle_top_right_x_y; rectangle_bottom_left_x_y; rectangle_bottom_right_x_y];

% Show the extracted rectangle
%rectangle = img(rectangle_top_left_x_y(2):rectangle_bottom_right_x_y(2), rectangle_top_left_x_y(1):rectangle_bottom_right_x_y(1));
%imshow(rectangle);

rectangle_random_values = rand(4, 2)* x_y_random_value_length + x_y_random_value_range(1);

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

I = zeros(1, amount_of_grid_elements);
Iw = zeros(1, amount_of_grid_elements);

for coordinate_number = 1:amount_of_grid_elements
    
    I(coordinate_number) =  img(round(grid_coords(2, coordinate_number)), round(grid_coords(1, coordinate_number)));
    Iw(coordinate_number) =  img(round(back_warp_coords(2, coordinate_number)), round(back_warp_coords(1, coordinate_number)));
end

displacement_vector = reshape(rectangle_random_values, [], 1);


% Draw the grid that is created by back warping
% imshow(img);
% hold on
% plot(back_warp_coords(1, :), back_warp_coords(2, :), 'o');



% Check the correctness of result
% newcords = H*rectangle_coords_homog;
% newcords = newcords ./ repmat( newcords(3,:), 3, 1 );
% newcords - rectangle_new_coords_homog





