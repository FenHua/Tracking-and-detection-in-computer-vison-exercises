function [ occurance ] = Robust_Harris(Image, N, lambda_region, angles_region) %, distance_threshold, points_threshold )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

C = corner(Image, 'Harris');

cr = C(:, 2);
cc = C(:, 1);

occurance = zeros(size(Image));
trans = Random_Transformations(N, lambda_region, angles_region);

for i = 1 : N
    
    t1 = maketform('affine', trans(:, :, N));
    [Image1, xdata, ydata] = imtransform(Image, t1);

    C1 = corner(Image1, 'Harris');
    
    U_back = C1(:, 1) + xdata(1) - 1;
    V_back = C1(:, 2) + ydata(1) - 1;

   [Col, Row] = tforminv(t1, U_back, V_back);
   
   for  a = 1 : size(Col,1)
        
        Col(a, 1) = min( size(Image,2)  ,   max(1 , uint32(round(Col(a,1))) )  );
        Row(a, 1) = min( size(Image,1)  ,   max(1 , uint32(round(Row(a,1))) )  );
   
   end
   
   for j = 1 : size(Col, 1)
       
       occurance(Row(j,1), Col(j,1)) = occurance(Row(j,1), Col(j,1)) + 1;
      
   end
   
end
