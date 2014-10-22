% First exercise: demostration of implemented covolution function by
% applying a mean filter to a test image. Two types of border treatment are
% shown here: 'symmetric' and 'replicate'.

%% Computation

clc; clear; close all;

img_orig = rgb2gray(imread('peppers.png'));
kernel = ones(3,3)/9;

padded_img_symmetric = pad_matrix(img_orig, 30, 30, 'symmetric');
padded_img_replicated = pad_matrix(img_orig, 30, 30, 'replicate');

convoluted_img_symmetric = convolution(img_orig, kernel, 'symmetric');
convoluted_img_replicate = convolution(img_orig, kernel, 'replicate');

%% Demonstration of padding

close all;

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(padded_img_symmetric))
title('Padded image with symmetric border treatment');

figure, imshow(uint8(padded_img_replicated))
title('Padded image with replicated border treatment');


%% Demostration of convolution

close all;

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(convoluted_img_symmetric))
title('Convoluted image with symmetric border treatment');

figure, imshow(uint8(convoluted_img_replicate))
title('Convoluted image with replicated border treatment');
