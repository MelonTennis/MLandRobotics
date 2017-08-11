function W = getAdjacencyMatrix(data, neighbors, sigma)
% getAdjacencyMatrix Returns kNN similarity graph
%   'data' - A d-by-n matrix containing n d-dimensional data points
%   'k' - Number of neighbors
%   'sigma' - Parameter for Gaussian similarity function. Set
%      this to 0 for an unweighted graph. Default is 1.

n = size(data, 2);

% Preallocate memory
indi = zeros(1, neighbors * n);
indj = zeros(1, neighbors * n);
inds = zeros(1, neighbors * n);

for ii = 1:n
    % Compute i-th column of distance matrix
    dist = distEuclidean(repmat(data(:, ii), 1, n), data);
    
    % Sort row by distance
    [s, O] = sort(dist, 'ascend');
    
    % Save indices and value of the k 
    indi(1, (ii-1)*neighbors+1:ii*neighbors) = ii;
    indj(1, (ii-1)*neighbors+1:ii*neighbors) = O(1:neighbors);
    inds(1, (ii-1)*neighbors+1:ii*neighbors) = s(1:neighbors);
end

% Create sparse matrix
W = sparse(indi, indj, inds, n, n);

clear indi indj inds dist s O;

% Construct either normal or mutual graph
% Normal
W = max(W, W');

if nargin < 3 || isempty(sigma)
    sigma = 1;
end

% Unweighted graph
if sigma == 0
    W = (W ~= 0);
% Gaussian similarity function
elseif isnumeric(sigma)
    W = spfun(@(W) (simGaussian(W, sigma)), W);
else
    ME = MException('InvalidArgument:NotANumber', ...
        'Parameter sigma is not numeric');
    throw(ME);
end

end