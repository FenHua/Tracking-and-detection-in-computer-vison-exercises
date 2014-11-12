run('G:/TUM/TDCV/vlfeat-0.9.19/toolbox/vl_setup');
vl_version verbose

image1 = single(rgb2gray(imread('tum_mi_1.jpg')));
image2 = single(rgb2gray(imread('tum_mi_2.jpg')));

[f1, d1] = vl_sift(image1) ;
[f2, d2] = vl_sift(image2) ;
[matches, scores] = vl_ubcmatch(d1, d2) ;

S =[];
S(1,:) = f1(1,matches(1,:));
S(2,:) = f1(2,matches(1,:));
S(3,:) = f2(1,matches(2,:));
S(4,:) = f2(2,matches(2,:));


[H Si] = RANSAC_DLT(S,5,10,70,50);

