function [data, labels] = getUrineData
% Create data for question 1, part E
% OUTPUT:
%       data: a 10000x25 matrix; the ith row is the data from the ith patient. Element (i,j) is the concentration of the jth protien in the ith patient.
%       labels: an 10000x1 matrix; each element (i, 1) represents the
%       true subtype of ith sample.
rng(17);

nsample_sub = 5000;
mu1 = rand(1,25)*11;
sigma1 = genRandCovMatrix(25);
r1 = mvnrnd(mu1,sigma1,nsample_sub);
labels1 = zeros(5000,1);

mu2 = rand(1,25)*14;
sigma2 = genRandCovMatrix(25);
r2 = mvnrnd(mu2,sigma2,nsample_sub);
labels2 = ones(5000,1);

data=[r1;r2];
labels = [labels1;labels2]; %10000 by 1

% permute the data
rp = randperm(10000);
data=data(rp,:);
labels=labels(rp);
end

function M = genRandCovMatrix(n)
% Generate a random covariance matrix
M = rand(n,n);
M = M+M';
M = M + n*eye(n);
end