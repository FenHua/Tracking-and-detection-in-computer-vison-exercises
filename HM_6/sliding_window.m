
img = rgb2gray( imresize(imread('face1.jpg'), 0.5) );

haar_features = myHaarFeatures();
classifier = AdaboostClassifierFace();

int_img = calc_Integral_Image(img);

result = nlfilter(int_img, [19 19], @(img_patch) ( classifier.classify(haar_features.Compute_Haar_response(img_patch)) ));

%% 

subscripts = find(result);
img_size = size(result);
imshow(img);
hold on;

for i = 1:50 %size(subscripts)
    
    [row, col] = ind2sub(img_size, subscripts(i));
    rectangle('Position', [col-8 row-8 19 19], 'LineWidth', 1, 'EdgeColor', 'b');
end

