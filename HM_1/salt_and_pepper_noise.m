function [ resulted_img ] = salt_and_pepper_noise( input_img, percentage_of_corrupted_pixels )
    %SALT_AND_PEPPER_NOISE Summary of this function goes here
    %   Detailed explanation goes here
    
    resulted_img = input_img;
    amount_of_pixels = size(input_img, 1)*size(input_img, 2);
    random_index = randperm(amount_of_pixels);
    amount_of_pixels_to_be_corrupted = floor(amount_of_pixels*percentage_of_corrupted_pixels);
    amount_of_salt_pixels = floor(amount_of_pixels_to_be_corrupted * 0.5);
    resulted_img(random_index(1:amount_of_pixels_to_be_corrupted)) = 0;
    resulted_img(random_index(1:amount_of_salt_pixels)) = 255;

end

