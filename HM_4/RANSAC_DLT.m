function [ newH, inliers_set ] = RANSAC_DLT( S, s,t, T, N )
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here

    best_inliers_count = -1;
    inliers_set = [];
    for i = 1 :N
        
        random_index = randperm(size(S,2));
        sample = S(:, random_index(1:s));
        X = [sample(1:2,:); ones(1,size(sample,2))];
        Xw = [sample(3:4,:); ones(1,size(sample,2))];
        H = DLT(X, Xw);
        
        Xall = [S(1:2,:); ones(1,size(S,2))];
        Xwall = [S(3:4,:); ones(1,size(S,2))];
        
        Xwnew = H*Xall;
        
        Xwnew = Xwnew ./ repmat( Xwnew(3,:), 3, 1 );
        
        dist = sqrt( (Xwnew(1,:) - Xwall(1,:)).^2 +  (Xwnew(2,:) - Xwall(2,:)).^2);
        
        Si = [];
        
        for d = 1 : length(dist);
            
            if dist(1,d) < t
                
                Si = [Si d];
                                              
            end
            
        end
        
        if length(Si)> T
            
            inliers_set = S(: ,Si);
            Xin = [inliers_set(1:2,:); ones(1,size(inliers_set,2))];
            Xwin = [inliers_set(3:4,:); ones(1,size(inliers_set,2))];
            newH = DLT(Xin,Xwin);
            
            
            break;
            
        else
            
            if length(Si) > best_inliers_count
                
                best_inliers_count = length(Si);
                inliers_set = S(: ,Si);  
                           
            end
                        
            continue;
            
        end 
    
    end 

    Xin = [inliers_set(1:2,:);ones(1,size(inliers_set,2))];
    Xwin = [inliers_set(3:4,:);ones(1,size(inliers_set,2))];
    newH = DLT(Xin,Xwin);

end

