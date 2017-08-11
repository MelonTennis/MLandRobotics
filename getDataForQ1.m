function [ X, Y ] = getDataForQ1()
%GETDATAFORQ1 Read data for Q1
X = csvread('twomoon_small.csv');
Y = X(:,1);
X = X(:,2:3);
X = normc(X);
end