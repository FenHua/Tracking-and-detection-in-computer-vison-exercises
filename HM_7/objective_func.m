function [ result ] = objective_func( x, A, M, m )
    %OBJECTIVE_FUNC Summary of this function goes here
    %   Detailed explanation goes here

    alpha_val = x(1);
    beta_val = x(2);
    gamma_val = x(3);
    t_1 = x(4);
    t_2 = x(5);
    t_3 = x(6);

    rotation_matrix = rotation_matrix_3d(alpha_val, beta_val, gamma_val);
    
    translation_vector = [t_1; t_2; t_3];

    projection_matrix = A*[rotation_matrix, translation_vector];
    
    projected_m = projection_matrix*M;
    
    projected_m(1, :) = projected_m(1, :) ./ projected_m(3, :);
    projected_m(2, :) = projected_m(2, :) ./ projected_m(3, :);
    projected_m(3, :) = ones(1, size(projected_m(3, :), 2));
    
    result = (projected_m - m);
    result = sum(sum(result.*result));
    
    % 4th task. Using it for lsqnonlin()
    % result = sqrt(sum(result.*result));

end

