
Image = rgb2gray(imread('img1.ppm'));
lambda_region = [0.6 1.5];
angles_region = [-pi pi];
transformations_amount = 4000;
train_patch_size = 30;

% Choose only the stable ones.
C = corner(Image, 'Harris', 200);
amount_of_classes = size(C, 1);
fern_training_system = struct('fern_depth_s', 10, 'number_of_ferns_M', 20, 'number_of_classes_H', amount_of_classes, 'occurence_matrix', []);

Image_tmp = padarray(Image,[50 50],'symmetric');

%% Display selected points.


figure, imshow(Image);
hold on;

for i = 1:amount_of_classes
    plot(C(i, 1), C(i, 2), 'o');
end

%% Big 50x50 images. We use them in tranformation.

patch_size = [50 50];
patch_of_original_big_images = zeros(patch_size(1), patch_size(2), amount_of_classes);

for current_point_number = 1:amount_of_classes
    
    col = C(current_point_number, 1) + 50;
    row = C(current_point_number, 2) + 50;

    image_patch = Image_tmp( (row-patch_size/2):(row+patch_size/2)-1, (col-patch_size/2):(col+patch_size/2)-1);
    patch_of_original_big_images(:, :, current_point_number) = image_patch;
end

% demo
%imshow(uint8(patch_of_original_big_images(:, :, 3)))


%% Small 30x30 images that are taken from 50x50 ones after transformation.

transformations = Random_Transformations( transformations_amount, lambda_region, angles_region );

for current_class_number = 1:amount_of_classes 

    training_set = zeros(transformations_amount+1, train_patch_size*train_patch_size);
    class_lables = ones(1, transformations_amount + 1)*current_class_number;
    
    image_patch = patch_of_original_big_images(:, :, current_class_number);
    
    
    % Add original image without any transformation to training set.
    original_image_train_vector = image_patch( (25-train_patch_size/2):(25+train_patch_size/2)-1, (25-train_patch_size/2):(25+train_patch_size/2)-1);
    training_set(1, :) = original_image_train_vector(:)';

    for transformation_number = 2:transformations_amount

        t1 = maketform('affine', transformations(:,:,transformation_number));
        [transformed_patch, xdata, ydata] = imtransform(image_patch, t1);

        [U, V] = tformfwd(t1, 25, 25);

        U = U - xdata(1) + 1;
        V = V - ydata(1) + 1;

        col = round(U(1));
        row = round(V(1));
        
        % Add small 30x30 image to training set. It is of a smaller size to
        % prevent bad effect of black regions after transformation.
        training_patch = transformed_patch( (row-train_patch_size/2):(row+train_patch_size/2)-1, (col-train_patch_size/2):(col+train_patch_size/2)-1);

        feature_vector = training_patch(:)';
        training_set(transformation_number, :) = feature_vector;
    end

    fern_training_system = train_fern_system(training_set, class_lables, fern_training_system);
end

save('ferns_system_200_4000_class.mat', 'fern_training_system');

normsys = normalize_fern_training_system(fern_training_system);

check = classify_using_fern_system(normsys, original_image_train_vector(:)')









