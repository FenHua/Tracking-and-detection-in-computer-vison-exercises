
run('../../dependencies/vlfeat-0.9.19/toolbox/vl_setup');

intrinsic_matrix_A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];

img = rgb2gray( imread('img_sequence/0000.png') );

[f1, descriptor_of_initial_points] = vl_sift(single(img));

heterogeneous_coords_initial = [ f1(1:2, :); ones(1, size(f1, 2)) ];

% Using multiplication property. Every column will be a corresponding 3d
% coordinate.
global_coords_initial = inv(intrinsic_matrix_A) * heterogeneous_coords_initial;

%% Matching

img_next = rgb2gray( imread('img_sequence/0002.png') );

[f2, descriptor_of_next_image_points] = vl_sift(single(img_next));

[matches, scores] = vl_ubcmatch(descriptor_of_initial_points, descriptor_of_next_image_points);

S =[];
S(1, :) = f1(1, matches(1, :));
S(2, :) = f1(2, matches(1, :));
S(3, :) = f2(1, matches(2, :));
S(4, :) = f2(2, matches(2, :));

[H, inliers_numbers] = RANSAC_adaptive(S, 5, 1, 0.99);

%% Display together


imshow([img img_next]);

hold on;

for point_number = 1:20
    
    first_img_point = f1(1:2, matches(1, inliers_numbers(point_number)));
    second_img_point = f2(1:2, matches(2, inliers_numbers(point_number)));
    
    x1 = first_img_point(1)
    y1 = first_img_point(2)
    
    x2 = second_img_point(1) + size(img, 2);
    y2 = second_img_point(2);
    
    plot([x1 x2], [y1 y2], 'b', 'LineWidth', 0.2);
end



