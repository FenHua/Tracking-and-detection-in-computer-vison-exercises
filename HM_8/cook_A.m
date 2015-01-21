
amount_of_matrices = 50;
amount_of_parameters = 8;
smallest_deviation = 3;
biggest_deviation = 30;
img = rgb2gray( imread('images/0000.png') );

rectangle_top_left_x_y = [103, 76];
rectangle_bottom_right_x_y = [552, 383];

rectangle_top_right_x_y = [rectangle_bottom_right_x_y(1), rectangle_top_left_x_y(2)];
rectangle_bottom_left_x_y = [rectangle_top_left_x_y(1), rectangle_bottom_right_x_y(2)];

x_span = rectangle_top_left_x_y(1):5:rectangle_top_right_x_y(1);
y_span = rectangle_top_right_x_y(2):5:rectangle_bottom_right_x_y(2);

if x_span(end) ~= rectangle_top_right_x_y(1)
    x_span(end + 1) = rectangle_top_right_x_y(1);
end

if y_span(end) ~= rectangle_bottom_right_x_y(2)
    y_span(end + 1) = rectangle_bottom_right_x_y(2);
end

amount_of_grid_points = size(x_span, 2) * size(y_span, 2);

max_deviations = fliplr(linspace(smallest_deviation, biggest_deviation, amount_of_matrices));
A = zeros(amount_of_parameters, amount_of_grid_points, amount_of_matrices);

for current_step = size(max_deviations, 2);
    
    current_max_deviation = max_deviations(current_step);
    A(:, :, current_step) = learning( img, [-current_max_deviation, current_max_deviation], rectangle_top_left_x_y, rectangle_bottom_right_x_y );
end
