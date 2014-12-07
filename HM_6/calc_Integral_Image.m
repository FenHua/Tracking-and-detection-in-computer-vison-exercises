function [ int_img ] = calc_Integral_Image( img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


[r ,c] = size(img);

int_img = int64(img);

for i = 2 : c
    
    int_img(:,i) = int_img(:,i) + int_img(:,i-1);    
end

for i = 2 : r
    
    int_img(i,:) = int_img(i,:) + int_img(i-1,:);    
end

 int_img = [ zeros(r,1) int_img];
 int_img = [ zeros(1,c+1); int_img];


end