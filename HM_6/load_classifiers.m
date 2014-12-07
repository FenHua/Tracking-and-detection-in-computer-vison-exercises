
load('Classifiers.mat');

amount_of_classifiers = size(classifiers, 2);

classifiers_array = WeakClassifierFace.empty(0, amount_of_classifiers-1);

for current_classifier_number = 2:amount_of_classifiers
   
    current_classifier = WeakClassifierFace();
    current_classifier.Mean = classifiers(6, current_classifier_number);
    current_classifier.Max_pos = classifiers(8, current_classifier_number);
    current_classifier.Min_pos = classifiers(9, current_classifier_number);
    current_classifier.R = classifiers(10, current_classifier_number);
    classifiers_array(current_classifier_number-1) = current_classifier;
end