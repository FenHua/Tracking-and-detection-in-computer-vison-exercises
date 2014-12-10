
usual_window_size = 19;
img = rgb2gray( imresize(imread('face3.jpg'), 1) );

haar_features = myHaarFeatures();
classifier = AdaboostClassifierFace();
int_img = calc_Integral_Image(img);

imshow(img);
hold on;

for current_scale = 1:0.1:2
    
    scaled_window_size = ceil(usual_window_size * current_scale);
    half_scaled_window_size = floor(scaled_window_size*0.5);
    result = nlfilter(int_img, [scaled_window_size scaled_window_size ], @(img_patch) ( classifier.classify(haar_features.Compute_Haar_response(img_patch, current_scale)) ));
    subscripts = find(result);
    img_size = size(result);
    
    for i = 1:size(subscripts)
    
        [row, col] = ind2sub(img_size, subscripts(i));
        rectangle('Position', [col-half_scaled_window_size row-half_scaled_window_size scaled_window_size scaled_window_size], 'LineWidth', 1, 'EdgeColor', 'b');
    end
    
end
 
