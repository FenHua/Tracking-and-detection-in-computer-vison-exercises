
load('ferns_system_20_class.mat')

normsys = normalize_fern_training_system(fern_training_system);

% Points that the classifier was trained on
Image_orig = rgb2gray(imread('img1.ppm'));
trained_corners = corner(Image_orig, 'Harris', 20);

% New image.
Image = rgb2gray(imread('img2.ppm'));
corners_to_classify = corner(Image, 'Harris', 50);
amount_of_classes = size(corners_to_classify, 1);


%% Display selected points.


figure, imshow(Image);
hold on;

for i = 1:amount_of_classes
    plot(corners_to_classify(i, 1), corners_to_classify(i, 2), 'o');
end


%% Retrieve patches around possible points

patch_size = [30 30];
patch_of_original_big_images = zeros(patch_size(1), patch_size(2), amount_of_classes);

for current_point_number = 1:amount_of_classes
    
    col = corners_to_classify(current_point_number, 1);
    row = corners_to_classify(current_point_number, 2);

    image_patch = Image( (row-patch_size/2):(row+patch_size/2)-1, (col-patch_size/2):(col+patch_size/2)-1);
    patch_of_original_big_images(:, :, current_point_number) = image_patch;
end

% demo
%imshow(uint8(patch_of_original_big_images(:, :, 3)))

%% Classify points based on extracted patches

points_posterior = zeros(amount_of_classes, 20, 'double');

for current_point_number = 1:amount_of_classes
    
    current_point_patch = patch_of_original_big_images(:, :, current_point_number);
    points_posterior(current_point_number, :) = classify_using_fern_system(normsys, current_point_patch(:)');
end

%% Create matching array. First row point of first image, second row corresponding point from second image.

matches = zeros(2, 20);
for i = 1:20
    
    current_column = points_posterior(:, i);
    matches(1, i) = i;
    matches(2, i) = find(current_column==max(current_column));
end

%% 

trained_corners = trained_corners';
corners_to_classify = corners_to_classify';

S =[];

S(1, :) = trained_corners(1, matches(1, :));
S(2, :) = trained_corners(2, matches(1, :));
S(3, :) = corners_to_classify(1,matches(2, :));
S(4, :) = corners_to_classify(2,matches(2, :));

%[H Si] = RANSAC_DLT(S, 5, 1, 70, 50);

[H Si] = RANSAC_adaptive(S, 5, 1, 0.99);

im1 = Image_orig;
im2 = Image;


T = maketform('projective', H');

[im2t, xdataim2t, ydataim2t] = imtransform(im1, T);
xdataout=[min(1,xdataim2t(1)) max(size(im2, 2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(im2, 1),ydataim2t(2))];

im2t=imtransform(im1,T,'XData',xdataout,'YData',ydataout);
im1t=imtransform(im2,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

ims=im1t/2+im2t/2;
figure, imshow(ims)


