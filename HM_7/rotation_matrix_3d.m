function [ rotation_matrix ] = rotation_matrix_3d( alpha_val, beta_val, gamma_val )
    %ROTATION_MATRIX_3D Summary of this function goes here
    %   Detailed explanation goes here
    
    rotation_matrix_alpha = [ 1, 0, 0; 0, cos(alpha_val), sin(alpha_val); 0, -sin(alpha_val), cos(alpha_val)];
    rotation_matrix_beta = [ cos(beta_val), 0, -sin(beta_val); 0, 1, 0; sin(beta_val), 0, cos(beta_val)];
    rotation_matrix_gamma = [ cos(gamma_val), sin(gamma_val), 0; -sin(gamma_val), cos(gamma_val), 0; 0, 0, 1];
    rotation_matrix = rotation_matrix_alpha * rotation_matrix_beta * rotation_matrix_gamma;
end

