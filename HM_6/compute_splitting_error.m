function [ error, misclassified_points_index ] = compute_splitting_error( lables, weights, assigned_class )
    %COMPUTE_SPLITTING_ERROR Summary of this function goes here
    %   Detailed explanation goes here
    
    % Find misclassified class elements
    misclassified_points_index = find(lables ~= assigned_class);
    
    % Sum up the weights error
    error = sum(weights(misclassified_points_index));

end

