
%% Load images and create pyramid.

amount_of_layers = 5;
templates_by_layer_number = cell(amount_of_layers, 1);
images_by_layer_number = cell(amount_of_layers, 1);
amount_of_existing_orientations = zeros(amount_of_layers, 1);

current_img = imread('office_3.jpg');

img_orig = current_img;

template_top_left_x_y = [255, 330];
template_bottom_right_x_y = [303, 366];

current_template = current_img(template_top_left_x_y(2):template_bottom_right_x_y(2), template_top_left_x_y(1):template_bottom_right_x_y(1), :);

images_by_layer_number{amount_of_layers} = threshold_orientation( current_img, 2);
templates_by_layer_number{amount_of_layers} = threshold_orientation( current_template, 2);
amount_of_existing_orientations(amount_of_layers) = numel(templates_by_layer_number{amount_of_layers}) - sum(sum(isnan(templates_by_layer_number{amount_of_layers})));

for layer_number =  fliplr(1:(amount_of_layers-1))
    
    current_img = imresize(current_img, 0.5);
    current_template = imresize(current_template, 0.5);
    
    new_template =  threshold_orientation( current_template, 2);
    new_img = threshold_orientation( current_img, 2);
    
    % Make template size uneven.
    template_row_amount = size(new_template, 1);
    template_col_amount = size(new_template, 2);
    
    if mod(template_row_amount, 2) == 0
        new_template = new_template(1:(template_row_amount-1), :);
    end
    
    if mod(template_col_amount, 2) == 0
        new_template = new_template(:, 1:(template_col_amount-1));
    end
    
    templates_by_layer_number{layer_number} = new_template;
    images_by_layer_number{layer_number} = new_img;
    amount_of_existing_orientations(layer_number) = numel(templates_by_layer_number{layer_number}) - sum(sum(isnan(templates_by_layer_number{layer_number})));
end

%% Pyramid search.

tic

first_layer_img = images_by_layer_number{1};
first_layer_template = templates_by_layer_number{1};
first_amount_of_existing_orientations = amount_of_existing_orientations(1);
template_size = size(first_layer_template);
img_size = size(first_layer_img);

result = nlfilter(first_layer_img, template_size, @(patch) EM(first_layer_template, patch, first_amount_of_existing_orientations));

max_value = max(max(result))

[row, col] = ind2sub(img_size, find(result >= 0.8));

points_of_interest = [row col];

for layer_number = 2:amount_of_layers
    
    % Load current pyramid level template/img pair
    img = images_by_layer_number{layer_number};
    template = templates_by_layer_number{layer_number};
    current_amount_of_existing_orientations = amount_of_existing_orientations(layer_number);
    
    % Get interest points from the previous layer.
    row = points_of_interest(:, 1);
    col = points_of_interest(:, 2);
    
    % Coordinates of center pixels in a next bigger pyramid level.
    % One pixel in a smaller level corresponds to multiple pixels in a bigger
    % level, so some region centered at that pixels should be considered.
    row_new_coords = (row - 1)*2 + 1;
    col_new_coords = (col - 1)*2 + 1;
    
    % Just amount of interest points before expanding
    coords_batch_size = size(col, 1);
    
    % Part where we find all neighbourhood points in the next pyramid
    % layer.
    
    % Size of a border of a square region of a pixel to be considered.
    pixel_boundary_size = 1;

    boundary_span = -pixel_boundary_size:pixel_boundary_size;

    width_of_square = pixel_boundary_size*2 + 1;
    amount_of_elements_in_square = width_of_square^2;

    coords = zeros(coords_batch_size*amount_of_elements_in_square, 2);

    element_number_counter = 1;

    for row_displacement = boundary_span
        for col_displacement = boundary_span

            row_displaced_coords = row_new_coords + row_displacement;
            col_displaced_coords = col_new_coords + col_displacement;

            starting_element = (element_number_counter-1)*coords_batch_size + 1;
            end_element = element_number_counter*coords_batch_size;

            coords(starting_element:end_element, :) = [row_displaced_coords col_displaced_coords];

            element_number_counter = element_number_counter + 1;
        end
    end

    row_coords = coords(:, 1);
    col_coords = coords(:, 2);
    
    % Filter out the points that doesn't fit in the image.

    valid_points = row_coords > 0 & row_coords <= size(img, 1);
    valid_points = valid_points & (col_coords > 0 & col_coords <= size(img, 2));

    indexes = find(valid_points);

    coords = coords(valid_points, :);
    
    % Compute the results for the points that are left.

    result  = selected_nlfilter( img, coords, @(patch) EM(template, patch, current_amount_of_existing_orientations), size(template), 'symmetric');
    
    max_value = max(result);
    
    % Threshold value: 4 times the minimum value.
    index_of_points_for_next_level = find(result >= 0.8);
    
    points_of_interest = coords(index_of_points_for_next_level, :);
    
    size(points_of_interest)
    
end

[value, position] = max(result);

coordinates = coords(position, :);

toc

imshow(img_orig);
hold on;
plot(coordinates(2), coordinates(1), 'o');