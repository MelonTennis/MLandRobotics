function [dataset, labelset, datapool, labelpool] = infor_fs(prob, dataset, labelset, datapool, labelpool, step, fs)
% same as infor.m - query stragety by condifence or entropy
% input: prob: probability of each point belongs to each label, matrix of m*n
%        dataset & labelset: labeled set
%        datapool & labelpool: unlabeled set
%        step: each time query times
%        fs: chosen feature, not used in this function
% output: renew label & unlabeled data & label set
probnum = max(prob, [], 2) - min(prob, [], 2); % least confidence
%probnum = sum(prob.*log(prob) , 2); % most entropy
[~, index] = sort(probnum, 1);
index = index(1:step);
dataset = [dataset; datapool(index,:)];
labelset = [labelset; labelpool(index,:)];
datapool(index,:) = [];
labelpool(index,:) = [];
end


