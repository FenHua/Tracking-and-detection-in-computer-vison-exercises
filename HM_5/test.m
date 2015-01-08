
img = rgb2gray( imread('img1.ppm') );

% patch = img(30:300, 30:300)
% imshow(patch);

result = Harris_corner(img, 5, 1.5, 1.2, 0.06, 10);

points_of_interest_index = find(result > 0);

figure, imshow(img);
hold on;

for element = 1:size(points_of_interest_index)
        [x, y] = ind2sub( size(img), points_of_interest_index(element));
        plot(y, x, 'o');
end

%% 

patch_size = 50;

[x, y] = ind2sub( size(img), points_of_interest_index(234));


patch = img((x-patch_size/2):(x+patch_size/2), (y-patch_size/2):(y+patch_size/2));
imshow(patch);

% figure, imshow(img);
% hold on;
% plot(y, x, 'o');

%%
syms rot_angle lambda_1 lambda_2;

rotation_matrix = [cos(rot_angle) -sin(rot_angle); sin(rot_angle), cos(rot_angle)];
scale_matrix = [lambda_1 0; 0 lambda_2];

lambda_region = [0.6 1.5];
angles_region = [-pi pi];

lambda_one = rand(1)*(lambda_region(2)-lambda_region(1)) + lambda_region(1)
lambda_two = rand(1)*(lambda_region(2)-lambda_region(1)) + lambda_region(1)

theta = rand(1)*(angles_region(2)-angles_region(1)) + angles_region(1)
phi = rand(1)*(angles_region(2)-angles_region(1)) + angles_region(1)



R_theta = eval(subs(rotation_matrix, rot_angle, theta))
R_phi = eval(subs(rotation_matrix, rot_angle, phi))
R_phi_minus = eval(subs(rotation_matrix, rot_angle, -phi))
scale_matrix = eval(subs(scale_matrix, [lambda_1, lambda_2], [lambda_one, lambda_two]))
A = R_theta*R_phi_minus*scale_matrix*R_phi

H = [A, zeros(2, 1); 0 0 1]

T = maketform('affine', H)

im2t = imtransform(patch, T);

imshow(im2t)
