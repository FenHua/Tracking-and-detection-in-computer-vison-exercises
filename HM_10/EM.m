function [ result ] = EM( template, img_patch, template_amount_of_existing_orientations )
    %EM Summary of this function goes here
    %   Detailed explanation goes here
    
    result = abs(cos(template - img_patch));
    result(isnan(result)) = 0;
    result = sum(sum(result)) / template_amount_of_existing_orientations;
end

