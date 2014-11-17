function [ posterior_probabilities ] = classify_using_fern_system( normalized_fern_system, vector_to_classify )
    %CLASSIFY_USING_FERN_SYSTEM Summary of this function goes here
    %   Detailed explanation goes here

    posterior_probabilities = zeros(1, normalized_fern_system.number_of_classes_H);
    
    for current_fern_number = 1:normalized_fern_system.number_of_ferns_M
        
        fern_feature_vector = vector2fern_feature(vector_to_classify);
        
        for current_class_number = 1:number_of_classes_H
            
            posterior_probabilities(current_class_number) = ... 
                posterior_probabilities(current_class_number) + ... 
                normalize_fern_training_system.old_occurence_matrix(fern_feature_vector, current_class_number, current_fern_number); 
        end
    end
end

