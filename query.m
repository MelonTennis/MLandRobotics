function [ dists, n_queries ] = query( l, S )
%QUERY Measures the pairwise distance from l to each s in S
% l is an index
% S is an n x p data matrix
dists = zeros(size(S, 1), 1);
for i = 1:size(S, 1)
    dists(i) = norm(S(i,:) - S(l,:));
end
n_queries = size(S, 1);
end