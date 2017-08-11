function [ X, Y ] = getDataForQ3()
%GETDATAFORQ3 Reads the sequence dataset

X = csvread('sequence_dataset.csv');
Y = X(:,end);
X = X(:,1:end-1);
X = normc(X);

end