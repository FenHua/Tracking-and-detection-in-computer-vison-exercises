function [ prob_distribution ] = probMap( region, histogram )
    %PROBMAP Summary of this function goes here
    %   Detailed explanation goes here
    
    prob_distribution = zeros(size(region));

    for intensity_value = 0:255
       
        prob_distribution(region == intensity_value) = histogram(intensity_value + 1);
    end
end

