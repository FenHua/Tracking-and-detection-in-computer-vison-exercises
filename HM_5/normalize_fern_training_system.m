function [ normalized_probability_system_struct ] = normalize_fern_training_system( system_struct )
    %NORMALIZE_FERN_TRAINING_SYSTEM Summary of this function goes here
    %   Detailed explanation goes here
    
    normalized_probability_system_struct = system_struct;
    normalization = 1./sum(system_struct.occurence_matrix);
    normalized_probability_system_struct.occurence_matrix = bsxfun(@times, system_struct.occurence_matrix, normalization);
end

