function [ X, Y ] = getDataForQ2()
%GETDATAFORQ2 Returns the synthetic data used for Q2

X = csvread('../Q1/twomoon_small.csv');
Y = X(:,1);
X = X(:,2:3);
X = normc(X);

end