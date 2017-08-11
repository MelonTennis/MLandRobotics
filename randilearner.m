function [predict, accuracy, dec_value, train_data, train_label, dataset, labelset] = randilearner(dataset, labelset, train_data, train_label, nquery, test_data, test_label)
% random learner, each time choose nquery points randomly add to labeled points to train a model
% input: dataset & labelset: labeled set, has already used
%        train_data & train_label: data & label unused, choose randomly
%        test_data & test_label: use these data to test and get accuracy
% output: predit: result of prediction of testdata 
%         accuracy: accuracy of test
%         dec_value: probability estimation value of 1A1 SVM, matrix of m*n
%         train_data & train_label: data unlabeled, i.e. unused
%         dataset & labelset: data & label already used to train random earner
[m, n] = size(train_data);
if nquery > 0
    rate = datasample(1:m, nquery, 'Replace', false);
    dataset = [dataset; train_data(rate,:)];
    labelset = [labelset; train_label(rate,:)];
    train_data(rate,:) = [];
    train_label(rate,:) = [];
end
model = svmtrain(labelset, dataset, '-t 2 -b 1'); % RBF kernal
[predict, accuracy, dec_value] = svmpredict(test_label, test_data, model, '-b 1');
end

