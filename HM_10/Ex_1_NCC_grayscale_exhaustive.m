% Grayscale SSD exhaustive search time check

img = imread('office_3.jpg');

template_top_left_x_y = [255, 330];
template_bottom_right_x_y = [303, 366];

template = img(template_top_left_x_y(2):template_bottom_right_x_y(2), template_top_left_x_y(1):template_bottom_right_x_y(1), :);
imshow(template);

img = rgb2gray(img);
template = rgb2gray(template);
template_size = size(template);

tic

result = nlfilter(img, template_size, @(patch) NCC(template, patch));

largest_element_value = max(max(result));
[row, col] = ind2sub(size(img), find(result == largest_element_value));

toc

imshow(img);
hold on;
plot(col, row, 'o');