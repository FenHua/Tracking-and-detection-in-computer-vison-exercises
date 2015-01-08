function [ fern_feature_vector ] = vector2fern_feature( input_vector )
    %VECTOR2FERN_FEATURE Summary of this function goes here
    %   Detailed explanation goes here
    
    % TODO: Use 64 bit uint here.
    
    fern_feature_vector = 0;
    size_of_vector = size(input_vector, 2);
    
    for i = 1:(size_of_vector - 1)
        
        if input_vector(i) < input_vector(i+1)
            fern_feature_vector = fern_feature_vector + 1;
        end
        fern_feature_vector = bitshift(fern_feature_vector, 1);
    end
    
    % The last one is compared with the first one.
    if input_vector(size_of_vector) < input_vector(1)
        fern_feature_vector = fern_feature_vector + 1;
    end
end

