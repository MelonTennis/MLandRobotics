function [dataset, labelset, datapool, labelpool] = infor(prob, dataset, labelset, datapool, labelpool, step)
% query stragety by information
% each time add step points with conservative confidence or max entropy to data and label set
% input: prob: probability of each point belongs to each label, matrix of m*n
%        dataset & labelset: labeled set
%        datapool & labelpool: unlabeled set
%        step: each time query times
% output: renew label & unlabeled data & label set
probnum = max(prob, [], 2) - min(prob, [], 2); % conservative confidence
%probnum = sum(prob.*log(prob) , 2); % max entropy - 1/entropy
[~, index] = sort(probnum, 1); % ascending order
index = index(1:step);
dataset = [dataset; datapool(index,:)]; % renew data & label set - labeled
labelset = [labelset; labelpool(index,:)];
datapool(index,:) = []; % renew data & label pool - unlabeled
labelpool(index,:) = []; 
end


