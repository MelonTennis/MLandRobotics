function [model, error, prediction, aaccuracy, rerror, raccuracy, query] = repeat(N, data_train, label_train, data_test, label_test, max_query)
% repeat N times for each active learning method, with a random learner
% input: repeatnum, train data, train label, test data, test label, max
% query time
% output: active learning average error, last prediction of test data,
% active learning average accuracy, random average error, query time 
error = [];  % al average error
rerror = []; % random average error
aaccuracy = []; % al average accuracy
raccuracy = []; % random average accuracy
for iter = 1:N % run loop for N times, the same as YijiaJin_Project.m
    al_accuracy = [];
    ra_accuracy = [];
    al_error = [];
    ra_error = [];
    query = [];
    firstbatch = 150;
    [train_m, train_n] = size(data_train);
    rate = randsrc(1, train_m,[0 1; (1-firstbatch/train_m) firstbatch/train_m]);
    datapool = data_train;
    labelpool = label_train;
    labelset = [[]];
    dataset = [[]];
    querytime = 0;
    delete = [];
    for i = 1:train_m
        if rate(i) == 1
            dataset(end+1,:) = data_train(i,:);
            labelset(end+1,:) = label_train(i);
            querytime = querytime + 1;
            delete(end+1) = i;
        end
    end
    datapool(delete,:) = [];
    labelpool(delete,:) = [];
    rdata = dataset;
    rlabel = labelset;
    rdatapool = datapool;
    rlabelpool = labelpool;

    model = svmtrain(labelset, dataset, '-t 2 -b 1');
    [~, ~, prob] = svmpredict(labelpool, datapool, model, '-b 1');
    %[~, ~, dec] = svmpredict(labelpool, datapool, model);
    [alpre, accuracy, ~] = svmpredict(label_test, data_test, model, '-b 1');
    %[~, randi_accuracy, ~] = randomLearner(data_train, label_train, querytime, data_test, label_test);
    [rapre, randi_accuracy, ~, rdatapool, rlabelpool, rdata, rlabel] = randilearner(rdata, rlabel, rdatapool, rlabelpool, 0, data_test, label_test);
    al_error(end+1) = size(find(label_test ~= alpre),1);
    ra_error(end+1) = size(find(label_test ~= rapre),1);
    al_accuracy(end+1) = accuracy(1);
    ra_accuracy(end+1) = randi_accuracy(1);
    query(end+1) = querytime;

    % choose step points to the data set with most information 
    step = 15;
    while size(query,2) <= 150 % 150 = [maxQuerytime/step]
        % confidence & entropy
        [dataset, labelset, datapool, labelpool] = infor(prob, dataset, labelset, datapool, labelpool, step);
        % magin
        %[dataset, labelset, datapool, labelpool] = magin(dec, dataset, labelset, datapool, labelpool, step);
        % distance
        %[dataset, labelset, datapool, labelpool] = distance(dataset, labelset, datapool, labelpool, step);
        
        querytime = querytime + step;
        model = svmtrain(labelset, dataset, '-t 2 -b 1');
        [~, ~, prob] = svmpredict(labelpool, datapool, model, '-b 1');
        %[~, ~, dec] = svmpredict(labelpool, datapool, model);
        
        [alpre, accuracy, ~] = svmpredict(label_test, data_test, model, '-b 1');
        %[~, randi_accuracy, ~] = randomLearner(data_train, label_train, querytime, data_test, label_test);
        [rapre, randi_accuracy, ~, rdatapool, rlabelpool, rdata, rlabel] = randilearner(rdata, rlabel, rdatapool, rlabelpool, step, data_test, label_test);
        al_error(end+1) = size(find(label_test ~= alpre),1);
        ra_error(end+1) = size(find(label_test ~= rapre),1);
        al_accuracy(end+1) = accuracy(1);
        ra_accuracy(end+1) = randi_accuracy(1);
        query(end+1) = querytime;
    end
    if length(error) == 0
        error = al_error;
        rerror = ra_error;
        aaccuracy = al_accuracy;
        raccuracy = ra_accuracy;
    else
        error = error + al_error;
        rerror = rerror + ra_error;
        aaccuracy = aaccuracy + al_accuracy;
        raccuracy = raccuracy + ra_accuracy;
    end
end
[prediction, ~, ~] = svmpredict(label_test, data_test, model, '-b 1'); % get prediction from trained model
error = error/N;
rerror = rerror/N;
aaccuracy = aaccuracy/N;
raccuracy = raccuracy/N;
end

