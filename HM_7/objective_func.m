function [ result ] = objective_func( x, A, M, m )
    %OBJECTIVE_FUNC Summary of this function goes here
    %   Detailed explanation goes here

    alpha_val = x(1);
    beta_val = x(2);
    gamma_val = x(3);
    t_1 = x(4);
    t_2 = x(5);
    t_3 = x(6);

%     syms alphaa betaa gammaa t_1 t_2 t_3

%     rotation_matrix_alpha = [ 1, 0, 0; 0, cos(alpha_val), sin(alpha_val); 0, -sin(alpha_val), cos(alpha_val)];
%     rotation_matrix_beta = [ cos(beta_val), 0, -sin(beta_val); 0, 1, 0; sin(beta_val), 0, cos(beta_val)];
%     rotation_matrix_gamma = [ cos(gamma_val), sin(gamma_val), 0; -sin(gamma_val), cos(gamma_val), 0; 0, 0, 1];
%     rotation_matrix = rotation_matrix_alpha * rotation_matrix_beta * rotation_matrix_gamma;

      rotation_matrix = rotation_matrix_3d(alpha_val, beta_val, gamma_val);

%     rotation_matrix = eval(subs(rotation_matrix, [alphaa, betaa, gammaa], [alpha_val, beta_val, gamma_val]));

      translation_vector = [t_1; t_2; t_3];
%     translation_vector = eval(subs(translation_vector, [t_1, t_2, t_3], [t_1_val, t_2_val, t_3_val]));

    projection_matrix = A*[rotation_matrix, translation_vector];
    
    projected_m = projection_matrix*M;
    
    result = (projected_m - m);
    result = sum(sum(result.*result));

end

