
%% Initialization

x_c = 534;
y_c = 329;
width = 27;
height = 22;

car_top_left = [x_c - width, y_c - height];
car_bottom_right = [x_c + width, y_c + height];


img = imread('images/2043_000140.jpeg');

img = rgb2hsv(img);

img = round(img(:, :, 1) * 255);

region = img(car_top_left(2):car_bottom_right(2), car_top_left(1):car_bottom_right(1));

hist = colorHist(region);

%% Tracking

for image_number = 141:178

    img_name = sprintf('images/2043_%06d.jpeg', image_number);

    img = imread(img_name);

    reference_img = rgb2gray(img);

    img = rgb2hsv(img);

    img = round(img(:, :, 1) * 255);

    for iteration = 1:20

        region = img(car_top_left(2):car_bottom_right(2), car_top_left(1):car_bottom_right(1));

        probability_map = probMap(region, hist);

        denominator = sum(sum(probability_map));

        x_c_numerator = 0;
        y_c_numerator = 0;

        for x = 1:size(probability_map, 2)
            for y = 1:size(probability_map, 1)

                x_c_numerator = x_c_numerator + (x-1 + car_top_left(1))*probability_map(y, x);
                y_c_numerator = y_c_numerator + (y-1 + car_top_left(2))*probability_map(y, x);
            end
        end

        x_c = x_c_numerator / denominator
        y_c = y_c_numerator / denominator

        car_top_left = round([x_c - width, y_c - height]);
        car_bottom_right = round([x_c + width, y_c + height]);

    end

end

% imshow(reference_img);
% hold on;
% 
% rectangle('Position', [x_c - width, y_c - height, width*2, height*2]);
bar3(region);
bar(hist);

