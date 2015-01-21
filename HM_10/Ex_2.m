
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

