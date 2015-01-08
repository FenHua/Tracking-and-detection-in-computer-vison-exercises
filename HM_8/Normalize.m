function [ I_normalized ] = Normalize( I)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

I = I - mean(I);
I_normalized = I / std(I);


end