function [ result ] = NCC( template, img_patch )
    %NCC Summary of this function goes here
    %   Detailed explanation goes here
    
    template = double(template);
    img_patch = double(img_patch);
    
    denominator_template = sqrt(sum(sum(template.^2)));
    denominator_patch = sqrt(sum(sum(img_patch.^2)));
    
    numerator = (template(:))' * img_patch(:);
    
    result = numerator / (denominator_patch * denominator_template);
end

