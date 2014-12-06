
max_number_of_classifiers = 50;

load('data3.mat');

lables = dat(:, 3);
training_set = dat(:, [1 2]);
training_set_size = size(training_set, 1);
error_rate = zeros(1, max_number_of_classifiers);

for current_number_of_classifiers = 1:max_number_of_classifiers
    
    ada_boost_classifier = AdaboostClassifier(current_number_of_classifiers);
    ada_boost_classifier.train(training_set, lables);
    result = ada_boost_classifier.classify(training_set);
    amount_of_mistakes = sum(result ~= lables);
    error_rate(current_number_of_classifiers) = amount_of_mistakes / training_set_size;
end

plot(error_rate);

%% Plot before classification

first_class_index = find(lables == -1);
second_class_index = find(lables == 1);

first_class_elements = training_set(first_class_index, :);
second_class_elements = training_set(second_class_index, :);

figure, hold on;

plot(first_class_elements(:, 1), first_class_elements(:, 2), 'ro');
plot(second_class_elements(:, 1), second_class_elements(:, 2), 'bo');

%% Plot after classification

first_class_index = find(result == -1);
second_class_index = find(result == 1);

first_class_elements = training_set(first_class_index, :);
second_class_elements = training_set(second_class_index, :);

figure, hold on;

plot(first_class_elements(:, 1), first_class_elements(:, 2), 'ro');
plot(second_class_elements(:, 1), second_class_elements(:, 2), 'bo');
