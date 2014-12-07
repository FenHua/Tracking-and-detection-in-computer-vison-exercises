classdef AdaboostClassifierFace < handle
   properties
       
      Number_of_classifiers;
      Weak_classifiers = [];
      Classifiers_confidence = [];
      % Page 9 of original paper: strong classifier equation
      Strong_classifier_confidence_threshold;
   end
   methods
       
      function obj = AdaboostClassifierFace()
          
        load('Classifiers.mat');
        
        % First classifier is broken
        obj.Number_of_classifiers = size(classifiers, 2) - 1;
        obj.Weak_classifiers = WeakClassifierFace.empty(0, obj.Number_of_classifiers);
        obj.Classifiers_confidence = zeros(1, obj.Number_of_classifiers);

        for current_classifier_number = 2:obj.Number_of_classifiers+1

            current_classifier = WeakClassifierFace();
            current_classifier.Mean = classifiers(6, current_classifier_number);
            current_classifier.Max_pos = classifiers(8, current_classifier_number);
            current_classifier.Min_pos = classifiers(9, current_classifier_number);
            current_classifier.R = classifiers(10, current_classifier_number);
            obj.Weak_classifiers(current_classifier_number-1) = current_classifier;
            obj.Classifiers_confidence(current_classifier_number-1) = classifiers(11, current_classifier_number);
        end
        
         % Page 9 of original paper: strong classifier equation
        obj.Strong_classifier_confidence_threshold = sum(obj.Classifiers_confidence)*0.83;
      end
      
      function lables = classify(obj, testing_set)
          
        testing_set_size = size(testing_set, 1);
        result = zeros(testing_set_size, 1);

        for current_classifier_number = 1:obj.Number_of_classifiers

          current_classifier = obj.Weak_classifiers(current_classifier_number);
          current_classifier_confidence = obj.Classifiers_confidence(current_classifier_number);
          
          % Current feature classifier
          current_classification_result = current_classifier.classify(testing_set(:, current_classifier_number));
          confidence_classification_result = current_classification_result * current_classifier_confidence;
          result = result + confidence_classification_result;
        end

        lables = result >= obj.Strong_classifier_confidence_threshold;
      end
   end
end

