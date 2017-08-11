function [predict, accuracy, dec_value] = randomLearner(train_data, train_label, nquery, test_data, test_label)
% random learner svm classifier
% input: train_data: train data set
%        train_label: train data label
%        test_data & test_label
%        nquery: number of queries time
% output: accuracy: MSE error of test data set and value
%         predict: predict label of test data
%         dec_value: n*k matrix contains probability of each cluster
[train_m, train_n] = size(train_data);
rate = datasample(1:train_m,nquery,'Replace',false);
random_data = train_data(rate,:);
random_label = train_label(rate,:);
%random_label = random_label';
model = svmtrain(random_label, random_data, '-t 2 -b 1'); % RBF kernal
[predict, accuracy, dec_value] = svmpredict(test_label, test_data, model, '-b 1');
end

