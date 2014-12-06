classdef WeakClassifier < handle
   properties
      
      Splitting_dimension;
      Splitting_value;
      Smaller_partition_class;
      Error_rate;
   end
   methods
       
      function obj = WeakClassifier()
      end
      
      % @misclassified_train_index is used later for configuring weights
      % for next classifier. This values doesn't have to be stored.
      function misclassified_train_index = train(obj, training_set, lables, weights)
          
        dimensions_amount = size(training_set, 2);
        training_examples_amount = size(training_set, 1);
        min_error = Inf;

        for current_dimension = 1:dimensions_amount

            current_dimenstion_values = training_set(: , current_dimension);

            for current_threshold_number = 1:training_examples_amount

                % Current splitting threshold to test
                current_threshold = current_dimenstion_values(current_threshold_number);

                % Indexes of points that are smaller or equal to the tested
                % threshold.
                smaller_partition_index = find(current_dimenstion_values <= current_threshold);

                % Indexes of points that are bigger than tested threshold
                bigger_partition_index = (1:training_examples_amount)';
                % Delete elements
                bigger_partition_index(smaller_partition_index) = [];

                smaller_partition_lables = lables(smaller_partition_index);
                smaller_partition_weights = weights(smaller_partition_index);

                bigger_partition_lables = lables(bigger_partition_index);
                bigger_partition_weights = weights(bigger_partition_index);

                for smaller_partition_assigned_class = [-1 1]
                    
                    % Compute error in terms of sum of weights of
                    % misclassified set of points. Get the index of
                    % misclassified points.
                    [smaller_partition_error, smaller_partition_misclassified_index] = ...
                        compute_splitting_error(smaller_partition_lables, smaller_partition_weights, smaller_partition_assigned_class);

                    [bigger_partition_error, bigger_partition_misclassified_index]  =  ...
                        compute_splitting_error(bigger_partition_lables, bigger_partition_weights, smaller_partition_assigned_class*-1);
                    
                    % Combine errors from both sets and get the overall
                    % index of misclassified points.
                    error = smaller_partition_error + bigger_partition_error;
                    
                    if error < min_error
                        
                        misclassified_train_index = ... 
                            [smaller_partition_index(smaller_partition_misclassified_index); ...
                            bigger_partition_index(bigger_partition_misclassified_index)];

                        obj.Splitting_dimension = current_dimension;
                        obj.Splitting_value = current_threshold;
                        obj.Smaller_partition_class = smaller_partition_assigned_class;
                        
                        min_error = error;
                    end
                end
            end
        end
        
        obj.Error_rate = min_error / sum(weights);
      end
      
      function lables = classify(obj, testing_set)
          
          testing_dimension = testing_set(:, obj.Splitting_dimension);
          lables = (testing_dimension <= obj.Splitting_value)*obj.Smaller_partition_class;
          other_class_index = find(lables == 0);
          lables(other_class_index) = obj.Smaller_partition_class*(-1);
      end
   end
end

