%% small sections
%% read data
t_train = readtable('DIFFICULT_TRAIN.csv');
[n_train, d_train] = size(t_train); % size of train data
data_train = table2array(t_train(:, 1:d_train-1)); 
label_train = csvread('DIFFICULT_TRAIN_LABEL_NUMBER.csv');
t_test = readtable('DIFFICULT_TEST.csv');
[n_test, d_test] = size(t_test); % size of test data
data_test = table2array(t_test(:, 1:d_test-1));
label_test = csvread('DIFFICULT_TEST_LABEL_NUMBER.csv');

%% feature get
fs = csvread('hard_feature.csv');
data_test = data_test(:,find(fs));
data_train = data_train(:,find(fs));
%% plot
max_query = 2500; 
N = 10;
[model, alerror, prediction, alaccuracy, raerror, raaccuracy, query] = repeat(N, data_train, label_train, data_test, label_test, max_query);
figure
plot(query, alerror, 'g', query, raerror, 'r');
legend('active','random');
xlabel('query time');
ylabel('test error');
title('DIFFICULT data - confidence')
figure
plot(query, alaccuracy, 'g', query, raaccuracy, 'r');
legend('active','random');
xlabel('query time');
ylabel('test accuracy');
title('DIFFICULT data - confidence')
%% blind prediction
blind = csvread('DIFFICULT_BLINDED.csv');
bin = blind(:,1);
blind = blind(:, 2:end);
[bm, bn] = size(blind);
bl = zeros(bm, 1);
[blindpr, ~, ~] = svmpredict(bl, blind, model, '-b 1');
blindpr = [bin, blindpr];
csvwrite('DIFFICULT_BLIND_PRED.csv', blindpr);
%% get average
cee = csvread('n10cme.csv');
cea = csvread('n10cma.csv');
ceq = csvread('n10cmq.csv');
ree = csvread('n10cmre.csv');
rea = csvread('n10cmra.csv');
eee = csvread('n10eme.csv');
eea = csvread('n10ema.csv');
eeq = csvread('n10emq.csv');
mee = csvread('magineasyerror.csv');
meq = csvread('magineasyquery.csv');
figure
plot(ceq, cee, 'g', ceq, ree, 'r', eeq, eee, 'b');
legend('confidence','random', 'entropy');
title('MODERATE data - error/query time');
xlabel('query time');
ylabel('error');
figure
plot(ceq, cea, 'g', ceq, rea, 'r', eeq, eea, 'b');
legend('confidence','random', 'entropy');
title('MODERATE data - accuracy/query time');
xlabel('query time');
ylabel('accuracy');
%% num to string
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
%% change to name
easyp = csvread('DIFFICULT_BLIND_PRED.csv');
easyc = num2cell(easyp);
for i = 1:size(easyp,1)
    easyc(i,2) = C(easyp(i,2)+1);
end
easyt = cell2table(easyc);
writetable(easyt, 'DIFFICULT_P.csv');
