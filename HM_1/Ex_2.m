% Second exercise: demostration of implemented function for creating a
% kernel of gaussian smoothing with specified deviation; Demostration of
% equivalence of combined 1d verical+horizontal gaussian connvolution and 2d
% gaussian convolution with the same deviation.

%% Computation

clc; clear; close all;

img_orig = rgb2gray(imread('peppers.png'));

kernel_2d_dev_1 = gaussian_2d_kernel(1);
kernel_2d_dev_15 = gaussian_2d_kernel(15);

result_2d_dev_1 = convolution(img_orig, kernel_2d_dev_1, 'symmetric');

% 2d gaussian covolution takes more time than its equivalent combined of
% two 1d gaussian convolutions. This is especially true when the size of
% convolution is big.

tic
result_2d_dev_15 = convolution(img_orig, kernel_2d_dev_15, 'symmetric');
toc

kernel_1d_vert = gaussian_1d_kernel(15, 'vertical');
kernel_1d_horiz = gaussian_1d_kernel(15, 'horizontal');

tic
result_1d_dev_15 = convolution(img_orig, kernel_1d_horiz, 'symmetric');
result_1d_dev_15 = convolution(result_1d_dev_15, kernel_1d_vert, 'symmetric');
toc

%% Demonstration of gaussian smoothing

close all;

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(result_2d_dev_1))
title('Smoothed image with deviation=1');

figure, imshow(uint8(result_2d_dev_15))
title('Smoothed image with deviation=15');

%% Demonstration of equivalence of 2d gaussian and 1d vertical+horizontal gaussian

close all;

result = (result_1d_dev_15 - result_2d_dev_15).^2;

% Squared difference error
result = sum(sum(result))

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(result_2d_dev_15))
title('Image smoothed by 2d gaussian convolution with deviation=1');

figure, imshow(uint8(result_1d_dev_15))
title('Image smoothed by vertical and horizontal 1d gaussian convolution with deviation=1');



