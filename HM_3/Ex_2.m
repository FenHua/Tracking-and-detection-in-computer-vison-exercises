%

img = imread('cameraman.tif')
% img = imread('lena.gif');
img_2 = imresize(img, 0.5);

resolution_levels = 5;
s0 = 1.5;
k = 2;
alpha = 0.06;
threshold_h = 1500;
threshold_l = 6;


result = Harris_Laplace( img, s0, k, alpha, threshold_h, threshold_l, resolution_levels);
result_2 = Harris_Laplace( img_2, s0, k, alpha, threshold_h, threshold_l, resolution_levels);

%% 

clc; close all;

figure, imshow(img);
hold on;

for i = 1:size(result, 1)
    circle_size = s0 * k^(result(i,3)) * 6;
    plot(result(i, 2), result(i, 1), 'o', 'MarkerSize', circle_size);
end


figure, imshow(img_2);
hold on;

for i = 1:size(result_2, 1)
    circle_size = s0 * k^(result(i,3)) * 6;
    plot(result_2(i, 2), result_2(i, 1), 'o', 'MarkerSize', circle_size);
end

%% 

dev = 1;

img = imread('coins.png');

% kernel = laplacian_2d_kernel(21);

kernel = fspecial('log', floor(6*dev+1), dev);
 
result = conv2(double(img), double(kernel), 'same');

imshow(uint8(result));





