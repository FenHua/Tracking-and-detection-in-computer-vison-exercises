
img = imread('lena.gif');

res = Harris_corner(img, 5, 1.5, 1.2, 0.1, 10); 

imshow(res);