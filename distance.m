function [dataset, labelset, datapool, labelpool] = distance(dataset, labelset, datapool, labelpool, step)
% nearest distance, not used
[m, n] = size(datapool);
d = zeros(m,1);
for i = 1:m
    for j = 1:size(dataset,1)
        d(i) = d(i) + sqrt(sum((datapool(i) - dataset(j)) .^ 2));
    end
end
[~, index] = sort(d, 1);
index = index(1:step);
dataset = [dataset; datapool(index,:)];
labelset = [labelset; labelpool(index,:)];
datapool(index,:) = [];
labelpool(index,:) = [];
end

