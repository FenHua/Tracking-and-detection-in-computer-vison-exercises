%% Simple Harris corner detector demonstration

img = imread('lena.gif');

result = Harris_corner(img, 5, 1.5, 1.2, 0.06, 10);

points_of_interest_index = find(result > 0);

figure, imshow(img);
hold on;

for element = 1:size(points_of_interest_index)
        [x, y] = ind2sub( size(img), points_of_interest_index(element));
        plot(y, x, 'o');
end
