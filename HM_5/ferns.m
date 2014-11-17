
amount_of_training_data = 10;
size_of_feature_vector = 12;
fern_depth_s = 3;
number_of_ferns_M = 4;
number_of_classes_H = 2;

training_data = rand(amount_of_training_data, size_of_feature_vector);

class_lables = [zeros(1, 2), ones(1, 2)];


fern_indexes = randperm(size_of_feature_vector);
pFern = ones(2^S,number_of_classes_H, number_of_ferns_M);


for current_feature_number = 1:amount_of_training_data
   
    for current_fern_number = 1:number_of_ferns_M
        
        begin_index = (current_fern_number-1)*fern_depth_s;
        end_index = current_fern_number*fern_depth_s;
        current_fern_region = fern_indexes(begin_index:end_index);
        feature_vector_for_current_fern = training_data(current_feature_number, current_fern_region);
        converted_feature_vector = vector2fern_feature(feature_vector_for_current_fern);
        pFern(converted_feature_vector, class_lables(current_feature_number), current_fern_number) = ...
            pFern(converted_feature_vector, class_lables(current_feature_number), current_fern_number) + 1; 
    end
end