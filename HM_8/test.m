frames = zeros(480,640,44);
img = rgb2gray( imread('images/0000.png') );

for i = 1 : 20
    
    img_name = sprintf('images/%04d.png', i);

    
    frames(:,:,i) = rgb2gray( imread(img_name) );
    
end


x_y_random_value_range = [-50, 50];
rectangle_top_left_x_y = [103, 76];
rectangle_bottom_right_x_y = [552, 383];

rectangle_top_right_x_y = [rectangle_bottom_right_x_y(1), rectangle_top_left_x_y(2)];
rectangle_bottom_left_x_y = [rectangle_top_left_x_y(1), rectangle_bottom_right_x_y(2)];
rectangle_coords = [rectangle_top_left_x_y; rectangle_top_right_x_y; rectangle_bottom_left_x_y; rectangle_bottom_right_x_y];
cords = [rectangle_coords'; ones(1, size(rectangle_coords, 1))];

% A = learning( img, x_y_random_value_range, rectangle_top_left_x_y, rectangle_bottom_right_x_y );
% load('A');

load('big_A_2.mat');

x_span = rectangle_top_left_x_y(1):5:rectangle_top_right_x_y(1);
y_span = rectangle_top_right_x_y(2):5:rectangle_bottom_right_x_y(2);

if x_span(end) ~= rectangle_top_right_x_y(1)
    x_span(end + 1) = rectangle_top_right_x_y(1);
end
    
if y_span(end) ~= rectangle_bottom_right_x_y(2)
    y_span(end + 1) = rectangle_bottom_right_x_y(2);
end

[x, y] = meshgrid(x_span, y_span);

grid_coords = [x(:) y(:)];

grid_coords = [ grid_coords'; ones(1, size(grid_coords, 1))];



% Initial coords and current. At the begining they are the same.
current_parameter = cords;
initial_parameter = cords;

gridpoints = grid_coords;

current_homography = [1 0 0; 0 1 0 ;0 0 1];

original_intensities = [];
current_frame = frames(:,:,1);


for j = 1 : size(gridpoints, 2)
    
   original_intensities = [original_intensities; double(img( round(gridpoints(2,j)), round(gridpoints(1,j)) )) ];
end


original_intensities = Normalize(original_intensities);

% for each frame
for i = 5:5
    
%     initial_parameter = current_parameter;

    current_frame = frames(:,:,i);

    %multiplying by the same matrix to get better estimation of the
    %parameter - 5 because it is adviced in the exercise
    
    for matrix_number = 1:size(A, 3)
        
        current_A = A(:, :, matrix_number);
        
        for mult = 1 : 10


            current_homography = DLT(initial_parameter, current_parameter);

            gridpositions = current_homography * gridpoints ;  %to warp according to the current parameters
            gridpositions = gridpositions ./ repmat( gridpositions(3,:), 3, 1 );

            I = [];

           % Extract image
           for j = 1 : size(gridpositions, 2)

                I = [I; current_frame(round(gridpositions(2,j)), round(gridpositions(1,j))) ];

           end

            I = Normalize(I);  

            diff = I - original_intensities;

            P = current_A * diff;

            %get P & cords into homogenous coordinate form

            P1 = P(1:4,1);
            P2 = P(5:8,1);
            newP = [P1 P2 ones(4,1)];

            newP'

            newP = current_parameter + newP' - [zeros(4, 1) zeros(4, 1) ones(4,1)]';


            update_homography = DLT(current_parameter, newP);


            new_homography = current_homography * update_homography;


            new_parameter = new_homography * initial_parameter;

            new_parameter = new_parameter ./ repmat( new_parameter(3,:), 3, 1 );

            current_parameter = new_parameter;


        end
    end
end


% plot and see if it works
            imshow(uint8(current_frame));
            hold on;
            plot(current_parameter(1,:),current_parameter(2,:),'r*');