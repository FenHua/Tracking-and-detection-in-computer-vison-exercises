function dist = bhattacharyya( histogram1 , histogram2 )
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here


     bcoeff = 0 ;
     
     for i = 1: length( histogram1 )
       bcoeff = bcoeff + sqrt( histogram1( i ) * histogram2( i ) ) ;
     end

     if abs( bcoeff - 1) < 10e-06
        dist = 0 ;
     else
        dist = sqrt(1 - bcoeff );
     end

end
