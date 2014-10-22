% Third exercise: demostration of gradient, magnitude, and kernel combined
% from several ones.

%% Computation

clc; clear; close all;

img_orig = rgb2gray(imread('peppers.png'));

Gradient_x = [-1 0 1; -1 0 1; -1 0 1];
Gradient_y = [-1 -1 -1; 0 0 0; 1 1 1];

result_x_gradient = convolution(img_orig, Gradient_x, 'symmetric');
result_y_gradient = convolution(img_orig, Gradient_y, 'symmetric');

Magnitude = (result_x_gradient).^2+(result_y_gradient.^2);
Magnitude = Magnitude.^1/2;
Orientation = atan(double(result_y_gradient./result_x_gradient));

kernel_1d_vert = gaussian_1d_kernel(1, 'vertical');
kernel_1d_horiz = gaussian_1d_kernel(1, 'horizontal');
x_overall_kernel = convolution(Gradient_x, kernel_1d_horiz, 'replicate');
y_overall_kernel = convolution(Gradient_y, kernel_1d_vert, 'replicate');

result_x_overall_convolution = convolution(img_orig, x_overall_kernel, 'symmetric');
result_y_overall_convolution = convolution(img_orig, y_overall_kernel, 'symmetric');


%% Demostrate separate gradient directions on image

close all;

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(result_x_gradient))
title('Gradient image. X direction');

figure, imshow(uint8(result_y_gradient))
title('Gradient image. Y dirrection');

%% Demostrate magnitude and orientations

close all;

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(Magnitude))
title('Magnitude');

figure, imshow(uint8(Orientation))
title('Orientation');

%% Demonstrate combined convolution that is possible due to associative law of convolution

close all;

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(result_x_overall_convolution))
title('Magnitude');

figure, imshow(uint8(result_y_overall_convolution))
title('Orientation');


