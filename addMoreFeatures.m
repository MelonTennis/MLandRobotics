function data = addMoreFeatures(data)

% INPUT: data - 10000x25 data matrix from getSerumData
% OUTPUT: data - 10000x35 matrix with 10 added feature columns
rng(21);

datamax = max(data(:));
datamin = min(data(:));

% create 10000 x 10 matrix of random values
newfeatures = rand(10000,10);

% convert to range [datamin datamax]
newfeatures = datamin + (datamax - datamin)*newfeatures;

% add to data matrix and randomly permute columns
data = [newfeatures(:,1:5), data, newfeatures(:,6:10)];