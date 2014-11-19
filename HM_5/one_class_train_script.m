
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

transformations_amount = 1000;

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
train_patch_size = 30;

training_set = zeros(transformations_amount+1, train_patch_size*train_patch_size);
class_lables = ones(1, transformations_amount + 1);

original_train_vector = image_patch( (25-train_patch_size/2):(25+train_patch_size/2)-1, (25-train_patch_size/2):(25+train_patch_size/2)-1);
training_set(1, :) = original_train_vector(:)';

for transformation_number = 2:transformations_amount
    
    t1 = maketform('affine', transformations(:,:,transformation_number));
    [transformed_patch, xdata, ydata] = imtransform(image_patch, t1);

    [U, V] = tformfwd(t1, 25, 25);

    U = U - xdata(1) + 1;
    V = V - ydata(1) + 1;

    col = round(U(1));
    row = round(V(1));
    
    training_patch = transformed_patch( (row-train_patch_size/2):(row+train_patch_size/2)-1, (col-train_patch_size/2):(col+train_patch_size/2)-1);

    feature_vector = training_patch(:)';
    training_set(transformation_number, :) = feature_vector;
end

system_struct = struct('fern_depth_s', 10, 'number_of_ferns_M', 20, 'number_of_classes_H', 1, 'occurence_matrix', []);

result = train_fern_system(training_set, class_lables, system_struct);

normsys = normalize_fern_training_system(result);

bi = classify_using_fern_system(normsys, original_train_vector(:)')











