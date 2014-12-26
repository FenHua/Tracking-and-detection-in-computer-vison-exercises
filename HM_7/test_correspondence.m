
% Select image number to compare with the 0 one.
image_number = 24;

load('correspondance_cell.mat');
img = rgb2gray( imread('img_sequence/0000.png') );

img_name = sprintf('img_sequence/%04d.png', image_number);
img_next = rgb2gray( imread(img_name) );

first_image_points_array = correspondence_cell{1};
correspondence_array = correspondence_cell{image_number + 1};

imshow([img img_next]);
hold on;

for point_number = 1:20%size(correspondence_array, 2)
    
    x1 = first_image_points_array(1, correspondence_array(1, point_number));
    y1 = first_image_points_array(2, correspondence_array(1, point_number));
    
    x2 = correspondence_array(2, point_number) + size(img, 2);
    y2 = correspondence_array(3, point_number);
    
    plot([x1 x2], [y1 y2], 'b', 'LineWidth', 0.2);
end

