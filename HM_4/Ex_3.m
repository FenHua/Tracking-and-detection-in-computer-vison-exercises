
run('sift/vlfeat-0.9.19/toolbox/vl_setup.m');

original_1 = rgb2gray(imread('tum_mi_1.JPG'));
original_2 = rgb2gray(imread('tum_mi_2.JPG'));

im1 = imread('tum_mi_1.JPG');
im2 = imread('tum_mi_2.JPG');

image1 = single(original_1);
image2 = single(original_2) ;


[f1, d1] = vl_sift(image1);
[f2, d2] = vl_sift(image2);
[matches, scores] = vl_ubcmatch(d1, d2);

S =[];
S(1, :) = f1(1,matches(1, :));
S(2, :) = f1(2,matches(1, :));
S(3, :) = f2(1,matches(2, :));
S(4, :) = f2(2,matches(2, :));

%[H Si] = RANSAC_DLT(S, 5, 1, 70, 50);

[H Si] = RANSAC_adaptive(S, 5, 1, 0.99);


T = maketform('projective', H')

[im2t,xdataim2t,ydataim2t]=imtransform(im1, T);
% now xdataim2t and ydataim2t store the bounds of the transformed im2
xdataout=[min(1,xdataim2t(1)) max(size(im2, 2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(im2, 1),ydataim2t(2))];
% let's transform both images with the computed xdata and ydata
im2t=imtransform(im1,T,'XData',xdataout,'YData',ydataout);
im1t=imtransform(im2,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

ims=im1t/2+im2t/2;
figure, imshow(ims)