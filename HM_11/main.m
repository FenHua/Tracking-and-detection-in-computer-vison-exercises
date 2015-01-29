% Initialization

N = 100;
x = 648;
y = 283;
w = 51;
h = 59;


img = imread('images/img000000.jpeg');


samples = zeros(2,N);
weights = ones(1,N);

weights = weights/N;

samples(1,1:N) = x;
samples(2,1:N) = y;

gaussian_noise = normrnd(0, 2 , size( samples ));

samples = samples + gaussian_noise;
features_prev = zeros(N,1080);

for sample_number = 1 : N
    
    b_x = round(samples(1,sample_number));
    b_y = round(samples(2,sample_number));
    
    
    bounded_box = img(b_y : b_y+h ,b_x : b_x+w);
    
    features = extractHOGFeatures(bounded_box);
    features = features/sum(features);
    features_prev(sample_number,:) =  features;
    
end

figure;
imshow(img);
hold on;
rectangle('Position',[648,283,51,59],'EdgeColor','r','LineWidth',2 );



%% Tracking
for frame_number = 1:20
    
    features_cur = zeros(N,1080);
    LH = zeros(1,N);

    img_name = sprintf('images/img%06d.jpeg', frame_number);

    frame = imread(img_name);% changed
    
    
    
    for sample_number = 1 : N
    
        b_x = round(samples(1,sample_number));
        b_y = round(samples(2,sample_number));


        bounded_box = frame(b_y : b_y+h ,b_x : b_x+w);

        features = extractHOGFeatures(bounded_box);
        features = features/sum(features);

        dist  = bhattacharyya(features_prev(sample_number,:),features);

        likelihood = 1/(1 + exp(10 * (dist)));
        %LH(1,sample_number) = likelihood;

        weights(1,sample_number) = weights(1,sample_number) * likelihood;

        features_cur(sample_number,:) =  features ;
    
    end

    weights = weights / sum(weights);
    
    [value, index] = max(weights);
    
    f_x = samples(1,index);
    f_y = samples(2,index);
    
    %showing the bounded box for the frame
%     close all;
    figure;
    imshow(frame);
    hold on;
    rectangle('Position',[f_x,f_y,w,h],'EdgeColor','r','LineWidth',2);
    
    new_samples = [];
    new_weights = [];
    new_HOG = [];
    
    [C, Ind] = sort(weights,'descend');
    count = 0;
    i = -1;
    %resampling
    for z = 1 : N
       
        i = Ind(1,z);
        
        cur_x = samples(1,i);
        cur_y = samples(2,i);
        cur_w = weights(1,i);
        cur_HOG = features_cur(i,:);
        
        cur_prob = round(weights(1,i) * N);
        
        
        if(cur_prob > 0 && count < N)
            
            count = count+cur_prob;
            
            if(count > N)
                
                cur_prob = cur_prob - (count - N);               
            end
            
            temp = zeros(2,cur_prob);
            temp_w = zeros(1,cur_prob);
            temp_HOG = zeros(cur_prob,size(cur_HOG,2));
            
            
            
            temp(1,1:cur_prob) = cur_x;
            temp(2,1:cur_prob) = cur_y;
            temp_w(1,1:cur_prob) = cur_w;
            
            for k = 1 : cur_prob
                
                temp_HOG(k,:) = cur_HOG;
            
            end 
            
            new_samples = [new_samples temp];
            new_weights = [new_weights temp_w];
            new_HOG = [new_HOG ;temp_HOG];
            
            
            
            
            
            
        end
        
              
    end
    %updating samples & histograms
    N = length(new_samples);
    samples = new_samples;
    weights = new_weights/sum(new_weights);
    features_prev = new_HOG;
    
    
    
    %calculating prior for the next frame
    gaussian_noise = normrnd(0, 1 , size( samples ));
    samples = samples + gaussian_noise;
    
    

    
    
    
    
  
end