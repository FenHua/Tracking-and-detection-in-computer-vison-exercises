classdef myHaarFeatures
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        featuresPositions;
        featuresType;
        featuresAttributes;
        
        
    end
    
    methods
        
        function obj = myHaarFeatures()
            
            
             load('Classifiers.mat');
            [r c] = size(classifiers);
            
            classifiers = classifiers(:,2:c);
            
            
            obj.featuresPositions = classifiers(1:2,:);
            obj.featuresAttributes = classifiers(3:4,:);
            obj.featuresType = classifiers(5,:);
            
        end
        
        function responses = Compute_Haar_response(obj, image, scale)
            
%           int_img = calc_Integral_Image(image);
            
            int_img = image;

            num_clas = size(obj.featuresType,2);
            
            responses = zeros(1, num_clas);
            
            for i = 1 : num_clas
                
                
                
                type = obj.featuresType(1,i);
                
                r = floor(obj.featuresPositions(1,i) * scale);
                c = floor(obj.featuresPositions(2,i) * scale);
                w = floor(obj.featuresAttributes(1,i) * scale);
                h = floor(obj.featuresAttributes(2,i) * scale);
                
               
                
                if type ==1
                    
                    
                   %R1
                   r1 = r;
                   c1 = c;
                   w1 = ceil((w/2) - 1);
                   h1 = h-1;
                   
                   %R2
                   r2 = r;
                   c2 = ceil(c+(w/2));
                   w2 = ceil((w/2) - 1);
                   h2 = h-1;
                   
                   
                   
                   Rec1 = int_img(r1 + h1 +1,c1+w1 +1) + int_img(r1,c1) - ( int_img(r1,c1+w1+1) + int_img(r1+h1+1,c1) );
                   
                   Rec2 = int_img(r2 + h2 +1,c2+w2 +1) + int_img(r2,c2) - ( int_img(r2,c2+w2+1) + int_img(r2+h2+1,c2) );
                   
                   responses(1,i) = Rec1 + Rec2;
                    
                end
                
                if type ==2
                    
                   %R1
                   r1 = r;
                   c1 = c;
                   w1 = w - 1;
                   h1 = ceil((h/2)-1);
                   
                   %R2
                   r2 = ceil(r + (h/2));
                   c2 = c ;
                   w2 = w - 1;
                   h2 = ceil((h/2)-1);
                   
                   Rec1 = int_img(r1 + h1 +1,c1+w1 +1) + int_img(r1,c1) - ( int_img(r1,c1+w1+1) + int_img(r1+h1+1,c1) );
                   
                   Rec2 = int_img(r2 + h2 +1,c2+w2 +1) + int_img(r2,c2) - ( int_img(r2,c2+w2+1) + int_img(r2+h2+1,c2) );
                   
                   responses(1,i) = Rec1 + Rec2;
                   
                end
                
                if type ==3
                    
                   %R1
                   r1 = r;
                   c1 = c;
                   w1 = ceil((w/3) - 1);
                   h1 = h-1;
                   
                   %R2
                   r2 = r;
                   c2 = ceil(c+(w/3));
                   w2 = ceil((w/3) - 1);
                   h2 = h-1;
                   
                   %R3
                   r3 = r;
                   c3 = ceil(c+(2*w/3));
                   w3 = ceil((w/3) - 1);
                   h3 = h-1;
                   
                   Rec1 = int_img(r1 + h1 +1,c1+w1 +1) + int_img(r1,c1) - ( int_img(r1,c1+w1+1) + int_img(r1+h1+1,c1) );
                   
                   Rec2 = int_img(r2 + h2 +1,c2+w2 +1) + int_img(r2,c2) - ( int_img(r2,c2+w2+1) + int_img(r2+h2+1,c2) );
                   
                   Rec3 = int_img(r3 + h3 +1,c3+w3 +1) + int_img(r3,c3) - ( int_img(r3,c3+w3 + 1) + int_img(r3+h3 +1,c3) );
                    
                   responses(1,i) = Rec1 - Rec2 + Rec3;
                end
                
                if type ==4
                    
                   %R1
                   r1 = r;
                   c1 = c;
                   w1 = w - 1;
                   h1 = ceil((h/3)-1);
                   
                   %R2
                   r2 = ceil(r+(h/3));
                   c2 = c ;
                   w2 = w - 1;
                   h2 = ceil((h/3)-1);
                   
                   %R3
                   r3 = ceil(r+(2*h/3));
                   c3 = c;
                   w3 = w - 1;
                   h3 = ceil((h/3)-1);
                   
                   Rec1 = int_img(r1 + h1 +1,c1+w1 +1) + int_img(r1,c1) - ( int_img(r1,c1+w1+1) + int_img(r1+h1+1,c1) );
                   
                   Rec2 = int_img(r2 + h2 +1,c2+w2 +1) + int_img(r2,c2) - ( int_img(r2,c2+w2+1) + int_img(r2+h2+1,c2) );
                   
                   Rec3 = int_img(r3 + h3 +1,c3+w3 +1) + int_img(r3,c3) - ( int_img(r3,c3+w3 + 1) + int_img(r3+h3 +1,c3) );
                    
                   responses(1,i) = Rec1 - Rec2 + Rec3;
                   
                end
                
                if type ==5
                    
                   %R1
                   r1 = r;
                   c1 = c;
                   w1 = ceil ((w/2) - 1);
                   h1 = ceil((h/2)-1);
                   
                   %R2
                   r2 = r;
                   c2 = ceil(c + (w/2));
                   w2 = ceil((w/2) - 1);
                   h2 = ceil((h/2)-1);
                   
                   %R3
                   r3 = ceil(r + (h/2));
                   c3 = c ;
                   w3 = ceil((w/2) - 1);
                   h3 = ceil((h/2)-1);
                   
                   %R4
                   r4 = ceil( r + (h/2));
                   c4 = ceil(c + (w/2));
                   w4 = ceil((w/2) - 1);
                   h4 = ceil((h/2)-1);
                   
                   Rec1 = int_img(r1 + h1 +1,c1+w1 +1) + int_img(r1,c1) - ( int_img(r1,c1+w1+1) + int_img(r1+h1+1,c1) );
                   
                   Rec2 = int_img(r2 + h2 +1,c2+w2 +1) + int_img(r2,c2) - ( int_img(r2,c2+w2+1) + int_img(r2+h2+1,c2) );
                   
                   Rec3 = int_img(r3 + h3 +1,c3+w3 +1) + int_img(r3,c3) - ( int_img(r3,c3+w3 + 1) + int_img(r3+h3 +1,c3) );
                   
                   Rec4 = int_img(r4 + h4 +1,c4+w4 +1) + int_img(r4,c4) - ( int_img(r4,c4+w4 +1) + int_img(r4+h4+1,c4) );
                    
                   responses(1,i) = Rec1 - Rec2 + Rec3 - Rec4;
                   
                end
                
                
                  
                
                
                              
            end
            
            
            
        end
        
    end
    
end
