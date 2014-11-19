
Image = rgb2gray(imread('img1.ppm'));

N = 25;
lambda_region = [0.6 1.5];
%lambda_region = [0.1 3];
angles_region = [-pi pi];

result = Robust_Harris(Image, N, lambda_region, angles_region);

C = corner(Image, 'Harris', 20);

X = C(:, 1);
Y = C(:, 2);

idx = sub2ind(size(result), Y, X);

check1 = result == 25;

check2 = result == 0;

amount_1 = sum(sum(check1))

amount_2 = sum(sum(check2))


