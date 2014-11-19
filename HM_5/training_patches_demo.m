
Image = rgb2gray(imread('img1.ppm'));
lambda_region = [0.6 1.5];
angles_region = [-pi pi];

C = corner(Image, 'Harris', 20);

figure, imshow(Image);
hold on;

for i = 1:size(C, 1)
    plot(C(i, 1), C(i, 2), 'o');
end

plot(C(10, 1), C(10, 2), 'o', 'MarkerSize', 100);

%% Genereate transform

transformations_amount = 5;

patch_size = [50 50];

test_point = [C(10, 1), C(10, 2)];

y = test_point(1);
x = test_point(2);

image_patch = Image( (x-patch_size/2):(x+patch_size/2)-1, (y-patch_size/2):(y+patch_size/2)-1);

imshow(image_patch);
hold on;
plot(25, 25, 'o'); 

%% transform patch

transformations = Random_Transformations( transformations_amount, lambda_region, angles_region );

t1 = maketform('affine', transformations(:,:,1));
[transformed_patch, xdata, ydata] = imtransform(image_patch, t1);

[U, V] = tformfwd(t1, 25, 25);

U = U - xdata(1) + 1;
V = V - ydata(1) + 1;

figure, imshow(transformed_patch);
hold on;

for i = 1:size(V, 1)
    plot(U(i), V(i), 'o');
end

%% get patch from transformed patch

train_patch_size = 30;

col = round(U(1));
row = round(V(1));
training_patch = transformed_patch( (row-train_patch_size/2):(row+train_patch_size/2)-1, (col-train_patch_size/2):(col+train_patch_size/2)-1);

imshow(training_patch);
hold on;

plot(15,15, 'o');











