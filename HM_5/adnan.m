%%

Image = rgb2gray(imread('img1.ppm'));
N = 10;
lambda_region = [0.6 1.5];
angles_region = [-pi pi];


C = corner(Image, 'Harris');

figure, imshow(Image);
hold on;

for i = 1:size(C, 1)
    plot(C(i, 1), C(i, 2), 'o');
end

%%
trans = Random_Transformations(N, lambda_region, angles_region);
t1 = maketform('affine', trans(:,:,1));
[Image1, xdata, ydata] = imtransform(Image, t1);

X = C(:, 1);
Y = C(:, 2);

[U, V] = tformfwd(t1, X, Y);

U = U - xdata(1) + 1;
V = V - ydata(1) + 1;

figure, imshow(Image1);
hold on;

for i = 1:size(V, 1)
    plot(U(i), V(i), 'o');
end

%%

U_back = U + xdata(1) - 1;
V_back = V + ydata(1) - 1;

[U, V] = tforminv(t1, U_back, V_back);


figure, imshow(Image);
hold on;

for i = 1:size(V, 1)
    plot(U(i), V(i), 'o');
end

