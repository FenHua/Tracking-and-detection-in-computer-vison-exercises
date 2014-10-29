
img_orig = imread('lena.gif');

test = bilateral_filter(img_orig, 9, 9, 'symmetric');
imshow(uint8(test));