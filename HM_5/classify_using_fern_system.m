function [ posterior_probabilities ] = classify_using_fern_system( normalized_fern_system, vector_to_classify )
    %CLASSIFY_USING_FERN_SYSTEM Summary of this function goes here
    %   Detailed explanation goes here

%     posterior_probabilities = zeros(1, normalized_fern_system.number_of_classes_H);
    
    posterior_probabilities = ones(1, normalized_fern_system.number_of_classes_H);
    
    for current_fern_number = 1:normalized_fern_system.number_of_ferns_M
        
        current_fern_region = normalized_fern_system.fern_indexes(current_fern_number, :);
        feature_vector_for_current_fern = vector_to_classify(current_fern_region);
        fern_feature_vector = vector2fern_feature(feature_vector_for_current_fern) + 1;
        
        for current_class_number = 1:normalized_fern_system.number_of_classes_H
            
            posterior_probabilities(current_class_number) = ... 
                posterior_probabilities(current_class_number) * ... 
                normalized_fern_system.occurence_matrix(fern_feature_vector, current_class_number, current_fern_number); 
        end
    end
end

