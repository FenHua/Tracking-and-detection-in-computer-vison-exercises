function [ result ] = train_fern_system( training_data, class_lables, system_struct )

    %TRAIN_FERN_SYSTEM Summary of this function goes here
    %   Detailed explanation goes here
    
    %     fern_depth_s = 3;
    %     number_of_ferns_M = 4;
    %     number_of_classes_H = 2;
    %     class_lables = [zeros(1, 2), ones(1, 2)];
    
    result.fern_depth_s = system_struct.fern_depth_s;
    result.number_of_ferns_M = system_struct.number_of_ferns_M;
    result.number_of_classes_H = system_struct.number_of_classes_H;
    old_occurence_matrix = system_struct.occurence_matrix;
    amount_of_training_data = size(training_data, 1);
    size_of_feature_vector = size(training_data, 2);
    
    % Case where we train system one more time.
    if isempty(old_occurence_matrix)
        % We use ones, according to the paper note.
        result.occurence_matrix = ones(2^S, result.number_of_classes_H, result.number_of_ferns_M);
        random_index = randperm(size_of_feature_vector);
        result.fern_indexes = zeros(result.number_of_ferns_M, result.fern_depth_s);
        
        for current_fern_number = 1:result.number_of_ferns_M
            begin_index = (current_fern_number-1)*result.fern_depth_s;
            end_index = current_fern_number*result.fern_depth_s;
            result.fern_indexes(current_fern_number, :) = random_index(begin_index:end_index);
        end
      
    else
        result.occurence_matrix = old_occurence_matrix;
    end
    
    
    for current_feature_number = 1:amount_of_training_data
   
        for current_fern_number = 1:number_of_ferns_M

            current_fern_region = fern_indexes(current_fern_number);
            feature_vector_for_current_fern = training_data(current_feature_number, current_fern_region);
            converted_feature_vector = vector2fern_feature(feature_vector_for_current_fern);
            result.occurence_matrix(converted_feature_vector, class_lables(current_feature_number), current_fern_number) = ...
                result.occurence_matrix(converted_feature_vector, class_lables(current_feature_number), current_fern_number) + 1;
        end
    end
    

end

