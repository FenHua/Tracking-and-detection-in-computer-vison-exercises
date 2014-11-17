%%
img = imread('lena.gif');

resolution_levels = 5;
s0 = 2;
k = 1.2;
alpha = 0.06;
threshold_h = 1500;
threshold_l = 10;

laplace_kernel = [[0 1 0]; [1 -4 1]; [0 1 0]];

[x_size, y_size] = size(img);
harris_scales_levels = zeros(x_size, y_size, resolution_levels);
interest_points = zeros(x_size, y_size, resolution_levels);


for level = 1:resolution_levels
    current_deviation = s0 * k^(level);
    current_level_layer = Harris_function(img, level-1, s0, k, alpha);
    interest_points(:, :, level) = nlfilter(current_level_layer, [3 3], @(x) (x(5) > threshold_h && all(x(5) > x([1:4 6:9]))));
    harris_scales_levels(:, :, level) = abs(current_deviation^2 * conv2(current_level_layer, laplace_kernel, 'same'));
end

points_of_interest_index = find(interest_points > 0);

%%

imshow(img);
hold on;

for element = 1:size(points_of_interest_index)
    [x, y, z] = ind2sub( size(harris_scales_levels), points_of_interest_index(element));
    plot(y, x, 'o');
end

%%

for element = 1:size(points_of_interest_index)
    [x, y, z] = ind2sub( size(harris_scales_levels), points_of_interest_index(element));
    
    if(harris_scales_levels(x, y, z) < threshold_l)
        points_of_interest_index(element) = 0;
    end
        
    if ((z-1) > 0)
        if(harris_scales_levels(x, y, z-1) >= harris_scales_levels(x, y, z))
            points_of_interest_index(element) = 0;
        end
    end
    
    if ((z+1) <= resolution_levels)
        if(harris_scales_levels(x, y, z+1) >= harris_scales_levels(x, y, z))
            points_of_interest_index(element) = 0;
        end
    end
end


%%

points_of_interest_index = points_of_interest_index(points_of_interest_index > 0);
imshow(img);
hold on;

for element = 1:size(points_of_interest_index)
    [x, y, z] = ind2sub( size(harris_scales_levels), points_of_interest_index(element));
    circle_size = s0 * k^(z) * 6;
    circle_size
    plot(y, x, 'o', 'MarkerSize', circle_size);
end


%%

result = Harris_Laplace( img, s0, k, alpha, threshold_h, threshold_l, resolution_levels);

