classdef WeakClassifierFace < handle
   properties

      % Face detection attributes
      Mean;
      Max_pos;
      Min_pos;
      R;
   end
   methods
       
      function obj = WeakClassifierFace()
      end
      
      function lables = classify(obj, testing_set)
          
          % Thresholds for positive output from homework paper
          lower_border = obj.Mean - abs(obj.Mean - obj.Min_pos)*(obj.R-5)/50;
          upper_border = obj.Mean + abs(obj.Max_pos - obj.Mean)*(obj.R-5)/50;
          
          % Threshold check
          lables = (testing_set <= upper_border);
          lables = lables .* (testing_set >= lower_border);
      end
   end
end