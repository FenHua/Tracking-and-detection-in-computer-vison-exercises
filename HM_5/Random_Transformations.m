function [ Transformations ] = Random_Transformations( N, lambda_region, angles_region )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Transformations = zeros(3,3,N);
    syms rot_angle lambda_1 lambda_2;

    rotation_matrix = [cos(rot_angle) -sin(rot_angle); sin(rot_angle), cos(rot_angle)];
    scale_matrix = [lambda_1 0; 0 lambda_2];

    for i = 1 : N
        lambda_one = rand(1)*(lambda_region(2)-lambda_region(1)) + lambda_region(1);
        lambda_two = rand(1)*(lambda_region(2)-lambda_region(1)) + lambda_region(1);

        theta = rand(1)*(angles_region(2)-angles_region(1)) + angles_region(1);
        phi = rand(1)*(angles_region(2)-angles_region(1)) + angles_region(1);

        R_theta = eval(subs(rotation_matrix, rot_angle, theta));
        R_phi = eval(subs(rotation_matrix, rot_angle, phi));
        R_phi_minus = eval(subs(rotation_matrix, rot_angle, -phi));
        scale_matrix = eval(subs(scale_matrix, [lambda_1, lambda_2], [lambda_one, lambda_two]));
        A = R_theta*R_phi_minus*scale_matrix*R_phi;

        Transformations(:,:,i) = [A, zeros(2, 1); 0 0 1];
    
    
    end
 
end