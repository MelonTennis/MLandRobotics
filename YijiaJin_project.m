%% ABR_Project_Image Classificatioin By Yijia_Jin
% data set EASY/MODERATE/DIFFICULT
t_train = readtable('DIFFICULT_TRAIN.csv');
[n_train, d_train] = size(t_train); % size of train data
data_train = table2array(t_train(:, 1:d_train-1)); 
label_train = csvread('DIFFICULT_TRAIN_LABEL_NUMBER.csv');
t_test = readtable('DIFFICULT_TEST.csv');
[n_test, d_test] = size(t_test); % size of test data
data_test = table2array(t_test(:, 1:d_test-1));
label_test = csvread('DIFFICULT_TEST_LABEL_NUMBER.csv');
max_query = 2500; % max query time

%% random learner test
%quertt = 2500;
%[randi_predict, randi_accuracy, randi_probability] = randomLearner(data_train, label_train, queryt, data_test, label_test);

%% active learner test
% first set of training data - random choose firstbatch data
al_accuracy = []; % active learning accuracy
ra_accuracy = []; % random learning accuracy
query = []; % saving query times
firstbatch = 150; % first use this set to get initial model of al and random
[train_m, train_n] = size(data_train);
rate = randsrc(1, train_m,[0 1; (1-firstbatch/train_m) firstbatch/train_m]);
datapool = data_train; % unlabeled data
labelpool = label_train; % unlabeled label
labelset = [[]]; % labeled label
dataset = [[]]; % labeled data
querytime = 0; % each query time 
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

model = svmtrain(labelset, dataset, '-t 2 -b 1'); % initial al model
[~, ~, prob] = svmpredict(labelpool, datapool, model, '-b 1'); % probability of each unlabeled point for each label size m*n
%[~, ~, dec] = svmpredict(labelpool, datapool, model);  % decision value size m*n(n-1)/2
[~, accuracy, ~] = svmpredict(label_test, data_test, model, '-b 1'); 
[~, randi_accuracy, ~, rdatapool, rlabelpool, rdata, rlabel] = randilearner(rdata, rlabel, rdatapool, rlabelpool, 0, data_test, label_test);
al_accuracy(end+1) = accuracy(1); % accuracy of al
ra_accuracy(end+1) = randi_accuracy(1); % accuracy of random
query(end+1) = querytime; 
plot(query, al_accuracy, 'g', query, ra_accuracy, 'r'); % plot each point
legend('active','random');

% choose step points to the data set with most information 
step = 15;
while querytime <= max_query
    [dataset, labelset, datapool, labelpool] = infor(prob, dataset, labelset, datapool, labelpool, step); % confidence & entropy
    %[dataset, labelset, datapool, labelpool] = magin(dec, dataset,labelset, datapool, labelpool, step); % magin value
    %[dataset, labelset, datapool, labelpool] = distance(dataset, labelset, datapool, labelpool, step);
    querytime = querytime + step;
    model = svmtrain(labelset, dataset, '-t 2 -b 1'); % renew model with query points
    
    [~, ~, prob] = svmpredict(labelpool, datapool, model, '-b 1'); % renew confidence
    %[~, ~, dec] = svmpredict(labelpool, datapool, model); % renew decision value
    [~, accuracy, ~] = svmpredict(label_test, data_test, model, '-b 1'); % renew accuracy
    [~, randi_accuracy, ~, rdatapool, rlabelpool, rdata, rlabel] = randilearner(rdata, rlabel, rdatapool, rlabelpool, step, data_test, label_test);
    al_accuracy(end+1) = accuracy(1); 
    ra_accuracy(end+1) = randi_accuracy(1);
    query(end+1) = querytime;
    hold on  % each time plot a point
    plot(query, al_accuracy, 'g', query, ra_accuracy, 'r');
    drawnow
    legend('active','random');
    xlabel('query time');
    ylabel('accuracy');
end
