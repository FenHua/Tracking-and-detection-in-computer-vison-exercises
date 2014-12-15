function [ newH, best_si ] = RANSAC_adaptive( S, s, t, p)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here

    best_inliers_count = -1;
    inliers_set = [];
    
    N = inf;
    sample_count = 1;
    lowest_ratio_of_outliners = 1;
    total_amount_of_points = size(S, 2);
    
    while sample_count < N

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
        
       amount_of_inliers = length(Si);
       ratio_of_outliers = 1 - amount_of_inliers/total_amount_of_points;
       
       if ratio_of_outliers < lowest_ratio_of_outliners
           lowest_ratio_of_outliners = ratio_of_outliers;
           N = log(1-p)/(log(1-(1-ratio_of_outliers)^s));
       end


        if length(Si) > best_inliers_count

            best_inliers_count = length(Si);
            best_si = Si;
            inliers_set = S(: ,Si);

        end
        
        sample_count = sample_count + 1; 

    end 

    Xin = [inliers_set(1:2,:); ones(1,size(inliers_set,2))];
    Xwin = [inliers_set(3:4,:); ones(1,size(inliers_set,2))];
    newH = DLT(Xin, Xwin);

end

