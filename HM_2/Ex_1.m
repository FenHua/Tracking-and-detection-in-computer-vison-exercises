%% Demostration of work of median filter

clc; clear; close all;

corrupted_img = imread('SaltAndPepperNoise.jpg');
filtered_img = median_filter(corrupted_img, [3 3], 'symmetric');

close all;

figure, imshow(corrupted_img)
title('Corrupted image');

figure, imshow(uint8(filtered_img))
title('Corrupted image after applying median filter');

%% Demostration of noise-adding functions

img_orig = rgb2gray(imread('peppers.png'));

img_gaussian_noise = gaussian_noise(img_orig, 5);
img_salt_pepper_noise = salt_and_pepper_noise(img_orig, 0.01);

close all;

figure, imshow(img_orig)
title('Original image');

figure, imshow(uint8(img_gaussian_noise))
title('Gaussian noise');

figure, imshow(uint8(img_salt_pepper_noise))
title('Salt and pepper noise');

%% Demostration of work of gaussian and median filters

gaussian_noise_after_median_filter = median_filter(img_gaussian_noise, [3 3], 'symmetric');
salt_pepper_noise_after_median_filter = median_filter(img_salt_pepper_noise, [3 3], 'symmetric');
gaussian_noise_after_gaussian_filter = gaussian_filter(img_gaussian_noise, 1);
salt_pepper_noise_after_gaussian_filter = gaussian_filter(img_salt_pepper_noise, 1);

figure, imshow(uint8(gaussian_noise_after_median_filter));
title('Median filter applied to gaussian noise corrupted image');

figure, imshow(uint8(salt_pepper_noise_after_median_filter));
title('Median filter applied to salt and pepper noise corrupted image');

figure, imshow(uint8(gaussian_noise_after_gaussian_filter));
title('Gaussian filter applied to gaussian noise corrupted image');

figure, imshow(uint8(salt_pepper_noise_after_gaussian_filter));
title('Gaussian filter applied to salt and pepper noise corrupted image');


figure, imshow(img_orig);



