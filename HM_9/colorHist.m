function [ histogram ] = colorHist( region )
    %COLORHIST Summary of this function goes here
    %   Detailed explanation goes here
    
    histogram = zeros(1, 256);
    
    for intensity_value = 0:255
       
        histogram(intensity_value + 1) = sum(sum(region == intensity_value));
    end

end

