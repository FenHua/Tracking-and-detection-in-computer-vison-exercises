classdef AdaboostClassifier < handle
   properties
       
      Number_of_classifiers;
      Weak_classifiers = [];
      Classifiers_confidence = [];
   end
   methods
       
      function obj = AdaboostClassifier(number_of_classifiers)
          
         obj.Number_of_classifiers = number_of_classifiers;
         obj.Weak_classifiers = WeakClassifier.empty(0, number_of_classifiers);
         obj.Classifiers_confidence = zeros(1, number_of_classifiers);
      end
      
      function train(obj, training_set, lables)
          
        training_examples_amount = size(training_set, 1);
        weights = ones(training_examples_amount, 1) * (1/training_examples_amount);
        
        for current_classifier_number = 1:obj.Number_of_classifiers
            
            current_classifier = WeakClassifier();
            misclassified_train_index = current_classifier.train(training_set, lables, weights);
            classifier_error_rate = current_classifier.Error_rate;
            classifier_alpha_confidence = log((1- classifier_error_rate)/classifier_error_rate);
            
            % Weight correction according to misclassified elements in
            % current classifier.
            weight_corrections = ones(training_examples_amount, 1);
            weight_corrections(misclassified_train_index) = exp(classifier_alpha_confidence);
            weights = weights .* weight_corrections;
            
            obj.Weak_classifiers(current_classifier_number) = current_classifier;
            obj.Classifiers_confidence(current_classifier_number) = classifier_alpha_confidence;
        end
      end
      
      function lables = classify(obj, testing_set)
          
          testing_set_size = size(testing_set, 1);
          result = zeros(testing_set_size, 1);
          
          for current_classifier_number = 1:obj.Number_of_classifiers
              
              current_classifier = obj.Weak_classifiers(current_classifier_number);
              current_classifier_confidence = obj.Classifiers_confidence(current_classifier_number);
              
              current_classification_result = current_classifier.classify(testing_set);
              confidence_classification_result = current_classification_result * current_classifier_confidence;
              result = result + confidence_classification_result;
          end
          
          lables = sign(result);
      end
   end
end

