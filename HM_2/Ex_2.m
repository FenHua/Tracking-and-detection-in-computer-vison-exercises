
%% Filtering with different parameters
img_orig = imread('lena.gif');

result = bilateral_filter(img_orig, 11, 11, 'symmetric');
result = uint8(result);
imshow(result);

imwrite(result, '11_11.bmp', 'bmp')

%% Comparing to gaussian smoothing

img_orig = imread('lena.gif');

bilateral = bilateral_filter(img_orig, 5, 5, 'symmetric');
bilateral = uint8(result);

gaussian_smoothing = gaussian_filter(img_orig, 5);
gaussian_smoothing = uint8(gaussian_smoothing);
imshow(bilateral - gaussian_smoothing);