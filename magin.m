function [dataset, labelset, datapool, labelpool] = magin(decvalue, dataset, labelset, datapool, labelpool, step)
% query strategy of simple margin
% each time add step points with max uncertainity data and label set
% renew data & label set & pool
% input: decvalue: decision value of 1A1 SVM, matrix of m*(n*(n-1))/2
%        dataset & labelset: labeled set
%        datapool & labelpool: unlabeled set
%        step: each time query times
% output: renew label & unlabeled data & label set
[m, n] = size(decvalue);
sepmargin = zeros(m, 1);
for i = 1:m
    positive = decvalue(i, decvalue(i,:)>0); % positive decision value
    negative = decvalue(i, decvalue(i,:)<0); % negative decision value
    if length(positive) ~= 0
        sepmargin(i) = sepmargin(i) + max(1-positive);
    end
    if length(negative) ~= 0
        sepmargin(i) = sepmargin(i) + max(1+negative);
    end
%    sepmargin(i) = size(abs(decvalue(i,:))>1, 1);
end
[p, index] = sort(sepmargin, 1);
index = index(1:step); % ascending order
dataset = [dataset; datapool(index,:)]; % add query points to labeled set
labelset = [labelset; labelpool(index,:)];
datapool(index,:) = []; % deduct query points from unlabeled set
labelpool(index,:) = [];
end

