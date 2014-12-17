
load('correspondance_cell.mat');

A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];

results = zeros(45, 6, 'double');

first_image_points_array = correspondence_cell{1};

for current_pose = 2:45
    
    correspondence_array = correspondence_cell{current_pose};

    first_image_matched_points = first_image_points_array(:, correspondence_array(1, :));
    first_image_matched_points_homog = [ first_image_matched_points; ones(1, size(first_image_matched_points, 2)) ];
    
    % Using multiplication property. Every column will be a corresponding 3d
    % coordinate.
    M = inv(A)*first_image_matched_points_homog;

    M = [M; ones(1, size(M, 2))];

    m = correspondence_array(2:3, :);

    m = [m; ones(1, size(m, 2))];

    results(current_pose, :) = fminsearch(@(x) objective_func(x, A, M, m), results(current_pose-1, :), optimset('MaxIter', 10000000000));
    
%     results(current_pose, :) = lsqnonlin(@(x) objective_func(x, A, M, m), results(current_pose-1, :), optimset('MaxIter', 10000000000));
end

%% World coordinates

world_coordinates = zeros(3, 45, 'double');
figure, hold on

for current_pose = 1:45
   
    alpha_val = results(current_pose, 1);
    beta_val = results(current_pose, 2);
    gamma_val = results(current_pose, 3);
    position_vector = results(current_pose, 4:end);
    world_coordinates(:, current_pose) = -(rotation_matrix_3d(alpha_val, beta_val, gamma_val)')*(position_vector');   
end

plot(world_coordinates(1, :), world_coordinates(2, :));
labels = cellstr( num2str([0:44]') );
text(world_coordinates(1, :), world_coordinates(2, :), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right');

% plot3(world_coordinates(1, :), world_coordinates(2, :), world_coordinates(3, :));
