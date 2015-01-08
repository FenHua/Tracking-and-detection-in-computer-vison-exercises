
%% Filtering with different parameters

% Results with different parameters are available in the same directory by
% the names of [distance_deviation]_[intensity_deviation].bmp

img_orig = imread('cutie.jpg');

result = zeros(size(img_orig), 'double');

for i = 1:3
    result(:, :, i) = bilateral_filter(img_orig(:,:, i), 3, 5, 'symmetric');
end

result = bilateral_filter(img_orig, 9, 11, 'symmetric');
result = uint8(result);
imshow(result);

%imwrite(result, '11_11.bmp', 'bmp')

%% Comparing to gaussian smoothing

img_orig = imread('lena.gif');

bilateral = bilateral_filter(img_orig, 5, 5, 'symmetric');
bilateral = uint8(result);

gaussian_smoothing = gaussian_filter(img_orig, 5);
gaussian_smoothing = uint8(gaussian_smoothing);
imshow(bilateral - gaussian_smoothing);