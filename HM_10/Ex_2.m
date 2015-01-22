
%% Preprocess.

img_orig = imread('office_3.jpg');

template_top_left_x_y = [255, 330];
template_bottom_right_x_y = [303, 366];

template = img_orig(template_top_left_x_y(2):template_bottom_right_x_y(2), template_top_left_x_y(1):template_bottom_right_x_y(1), :);

img_orientations = threshold_orientation( img_orig, 2);

template_orientations = threshold_orientation( template, 2);

amount_of_existing_orientations = numel(template_orientations) - sum(sum(isnan(template_orientations)));

%% Computation

result = nlfilter(img_orientations, size(template_orientations), @(patch)  EM(template_orientations, patch, amount_of_existing_orientations ) );

%% Show the result

max_value = max(max(result));

[row, col] = ind2sub(size(img_orientations), find(result == max_value) );

imshow(img_orig);
hold on;
plot(col, row, 'o');
