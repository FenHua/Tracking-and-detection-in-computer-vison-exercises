
run('../../dependencies/vlfeat-0.9.19/toolbox/vl_setup');

intrinsic_matrix_A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];

img = rgb2gray( imread('img_sequence/0000.png') );

[f1, descriptor_of_initial_points] = vl_sift(single(img));

%% Matching

correspondence_cell = cell(1, 45);

% First image feature points coordinates
correspondence_cell{1} = f1(1:2, :);

% In each correspondence array in correspondence_cell:
% first row is a number of matched point from the first image
% second and third values are for coordinates of matched point on the
% current image.

for image_number = 2:45
    
    image_number
    
    img_name = sprintf('img_sequence/%04d.png', image_number - 1);

    img_next = rgb2gray( imread(img_name) );
    
    [f2, descriptor_of_next_image_points] = vl_sift(single(img_next));

    [matches, scores] = vl_ubcmatch(descriptor_of_initial_points, descriptor_of_next_image_points);
    
    % Get pairs with smallest distance
    %     [sorted_values, sort_index] = sort(scores, 'descend');
    %     index_of_the_smallest_scores = sort_index(end-30:end);
    %     matches = matches(:, index_of_the_smallest_scores);
    %     matches = fliplr(matches);
    %     [~, ind, ~] = unique(matches(2, :));
    %     matches = matches(:, ind);


    %     S =[];
    %     S(1, :) = f1(1, matches(1, :));
    %     S(2, :) = f1(2, matches(1, :));
    %     S(3, :) = f2(1, matches(2, :));
    %     S(4, :) = f2(2, matches(2, :));
    % 
    %     [H, inliers_numbers] = RANSAC_adaptive(S, 5, 0.5, 0.99);
    
    x_1 = f1(1:2, matches(1, :));
    x_2 = f2(1:2, matches(2, :));

    [H, inliers_numbers] = ransacfithomography(x_1, x_2, 0.00001);
    
    correspondence_array = zeros(3, size(inliers_numbers, 2), 'double');
    
    for point_number = 1:size(inliers_numbers, 2)
    
        % Number of a point on the first image
        correspondence_array(1, point_number) = matches(1, inliers_numbers(point_number));
        
        second_img_point = f2(1:2, matches(2, inliers_numbers(point_number)));

        % Corresponding point on the second image coords (x, y) matlab's style.
        correspondence_array(2, point_number) = second_img_point(1);
        correspondence_array(3, point_number) = second_img_point(2);
    end
    
    correspondence_cell{image_number} = correspondence_array;
end











