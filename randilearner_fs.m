function [predict, accuracy, dec_value, train_data, train_label, dataset, labelset] = randilearner_fs(dataset, labelset, train_data, train_label, nquery, test_data, test_label, fs)
% random learner
% input: dataset & labelset: labeled data & label 
%        train_data & train_label: data & label unlabeled, random choose
%        nquery: query number
%        test_data & test_label: test set to get accuracy
%        fs: feature chosen (logical)
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
model = svmtrain(labelset, dataset(:,find(fs)), '-t 2 -b 1'); % RBF kernal
[predict, accuracy, dec_value] = svmpredict(test_label, test_data(:,find(fs)), model, '-b 1');
end

