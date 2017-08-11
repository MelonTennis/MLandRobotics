%% DIFFICULT data processing
%% get data
t_train = readtable('DIFFICULT_TRAIN.csv');
[n_train, d_train] = size(t_train); % size of train data
data_train = table2array(t_train(:, 1:d_train-1)); 
label_train = csvread('DIFFICULT_TRAIN_LABEL_NUMBER.csv');
t_test = readtable('DIFFICULT_TEST.csv');
[n_test, d_test] = size(t_test); % size of test data
data_test = table2array(t_test(:, 1:d_test-1));
label_test = csvread('DIFFICULT_TEST_LABEL_NUMBER.csv');
max_query = 2500; % max query time
%% add choose feature to active learning, most same as YijiaJin_project.m
% get some information from here: http://stackoverflow.com/questions/8288095/sequential-feature-selection-matlab
% get some infromation from here: http://www.mathworks.com/help/stats/sequentialfs.html
% first set of training data - random choose firstbatch data
f = @(xtrain, ytrain, xtest, ytest) sum(ytest ~= classify(xtest, xtrain, ytrain)); % error function
al_accuracy = [];
al_error = [];
ra_error = [];
ra_accuracy = [];
query = [];
firstbatch = 300; % first use these data to train and select features
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
% feature selection by sequential feature selection algorithm
% implement by MATLAB function
[fs,history] = sequentialfs(f, dataset, labelset);
model = svmtrain(labelset, dataset(:, find(fs)), '-t 2 -b 1'); % initial model

[~, ~, prob] = svmpredict(labelpool, datapool(:,find(fs)), model, '-b 1');
%[~, ~, dec] = svmpredict(labelpool, datapool, model);
[ap, accuracy, ~] = svmpredict(label_test, data_test(:,find(fs)), model, '-b 1');
[rp, randi_accuracy, ~, rdatapool, rlabelpool, rdata, rlabel] = randilearner_fs(rdata, rlabel, rdatapool, rlabelpool, 0, data_test, label_test, fs);
al_accuracy(end+1) = accuracy(1);
ra_accuracy(end+1) = randi_accuracy(1);
al_error(end+1) = size(find(label_test ~= ap),1);
ra_error(end+1) = size(find(label_test ~= rp),1);
query(end+1) = querytime;
% plot(query, al_accuracy, 'g', query, ra_accuracy, 'r');
% legend('active','random');
% choose step points to the data set with most information 
step = 20;
besta = 0; % single best selection 
while querytime <= max_query
    [fs,history] = sequentialfs(f, dataset, labelset);
    [dataset, labelset, datapool, labelpool] = infor_fs(prob, dataset, labelset, datapool, labelpool, step, fs);
    %[dataset, labelset, datapool, labelpool] = magin(dec, dataset, labelset, datapool, labelpool, step);
    %[dataset, labelset, datapool, labelpool] = distance(dataset, labelset, datapool, labelpool, step);
    querytime = querytime + step;
    model = svmtrain(labelset, dataset(:,find(fs)), '-t 2 -b 1');
    [~, ~, prob] = svmpredict(labelpool, datapool(:,find(fs)), model, '-b 1');
    %[~, ~, dec] = svmpredict(labelpool, datapool, model);
    [~, accuracy, ~] = svmpredict(label_test, data_test(:,find(fs)), model, '-b 1');
    [~, randi_accuracy, ~, rdatapool, rlabelpool, rdata, rlabel] = randilearner_fs(rdata, rlabel, rdatapool, rlabelpool, step, data_test, label_test, fs);
    if accuracy(1) > besta
        besta = accuracy(1); % best accuracy
        bestm = model; % return best model
    end
    al_accuracy(end+1) = accuracy(1); % active learning accuracy
    ra_accuracy(end+1) = randi_accuracy(1); % random learning accuracy
    al_error(end+1) = size(find(label_test ~= ap),1); % active learning error
    ra_error(end+1) = size(find(label_test ~= rp),1); % random learning error
    query(end+1) = querytime; % query time
%     hold on
%     plot(query, al_accuracy, 'g', query, ra_accuracy, 'r');
%     drawnow
%     legend('active','random');
%     xlabel('query time');
%     ylabel('accuracy');
%     title('DIFFICULT - confidence')
end
%%
blind = csvread('DIFFICULT_BLINDED.csv');
bin = blind(:,1);
blind = blind(:, 2:end);
[bm, bn] = size(blind);
bl = zeros(bm, 1);
[blindpr, ~, ~] = svmpredict(bl, blind, model, '-b 1');
blindpr = [bin, blindpr];
csvwrite('DIFFICULT_BLIND_PRED2.csv', blindpr);
%%
X = java_array('java.lang.String', 8);
X(1) = java.lang.String('Actin');
X(2) = java.lang.String('Endoplasmic_Reticulum');
X(3) = java.lang.String('Endosomes');
X(4) = java.lang.String('Lysosome');
X(5) = java.lang.String('Microtubules');
X(6) = java.lang.String('Mitochondria');
X(7) = java.lang.String('Peroxisomes');
X(8) = java.lang.String('Plasma_Membrane');
C = cell(X);
easyp = csvread('DIFFICULT_BLIND_PRED2.csv');
easyc = num2cell(easyp);
for i = 1:size(easyp,1)
    easyc(i,2) = C(easyp(i,2)+1);
end
easyt = cell2table(easyc);
writetable(easyt, 'DIFFICULT_P2.csv');
%% average
ava1 = csvread('d1e.csv');
ava2 = csvread('d2a.csv');
ava3 = csvread('d3a.csv');
ava4 = csvread('d4a.csv');
ava5 = csvread('d5a.csv');
ava = ava1(:,1:110) + ava2(:,1:110) +ava3(:,1:110) +ava4(:,1:110) +ava5(:,1:110);
ava = 100 - ava/5;
avra1 = csvread('d1re.csv');
avra2 = csvread('d2ra.csv');
avra3 = csvread('d3ra.csv');
avra4 = csvread('d4ra.csv');
avra5 = csvread('d5ra.csv');
avra = avra1(:,1:110) + avra2(:,1:110) +avra3(:,1:110) +avra4(:,1:110) +avra5(:,1:110);
avra = 100 - avra/5;
avq = csvread('d1q.csv');
figure
plot(avq, ava, 'g', avq, avra, 'r');
legend('confidence','random');
title('DIFFULT data - error rate/query time');
xlabel('query time');
ylabel('error rate');