
load('correspondance_cell_11.mat');

syms alpha_var beta_var gamma_var t_1 t_2 t_3;

syms_array = [alpha_var, beta_var, gamma_var, t_1, t_2, t_3];
jacobian_array = [];

A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];
rotation_matrix = rotation_matrix_3d(alpha_var, beta_var, gamma_var);
translation_vector = [t_1; t_2; t_3];

projection_matrix = A*[rotation_matrix, translation_vector];

first_image_points_array = correspondence_cell{1};

correspondence_array = correspondence_cell{2};

first_image_matched_points = first_image_points_array(:, correspondence_array(1, :));
first_image_matched_points_homog = [ first_image_matched_points; ones(1, size(first_image_matched_points, 2)) ];

% Using multiplication property. Every column will be a corresponding 3d
% coordinate.
M = inv(A)*first_image_matched_points_homog;

M = [M; ones(1, size(M, 2))];

m = correspondence_array(2:3, :);

m = [m; ones(1, size(m, 2))];

projected_m = projection_matrix*M;
result = (projected_m - m);
result = sum(sum(result.*result));

for sym_number = 1:size(syms_array, 2)
   
    jacobian_array = [ jacobian_array diff(result, syms_array(sym_number))];
end



