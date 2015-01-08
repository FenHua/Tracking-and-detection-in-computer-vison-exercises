function [ MatrixA ] = learning( img, x_y_random_value_range, rectangle_top_left_x_y, rectangle_bottom_right_x_y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = 800;

%range for random noise
a = -0.5;
b = 0.5;

MatrixP = [];
MatrixI =[];




    for i = 1:n  
    
        %this part to be done by daniil
    
        [ I, Iw, displacement_vector ] = random_transformation_system( img, x_y_random_value_range, rectangle_top_left_x_y, rectangle_bottom_right_x_y );
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        % normalize warped intensities
        Iw = Normalize(Iw);
    
        rand_noise = (b-a).*rand(size(Iw,1), 1) + a;

        Iw = Iw + rand_noise;
        
        % normalize original template intensities
        
        I = Normalize(I);
        
        
     
        %calculate normalized differences
        diffI = I - Iw;
        
        %add columns
        MatrixI = [MatrixI diffI];
        
        MatrixP = [MatrixP displacement_vector];
        
    
    end
    
    size(MatrixP)
    size(MatrixI)
    
    
    %Compute Matrix A
    
    PartA = MatrixP * MatrixI';
    PartB = MatrixI * MatrixI';
    
    MatrixA = PartA / (PartB);



end