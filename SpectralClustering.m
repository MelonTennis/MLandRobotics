function idx = SpectralClustering(data, k)
	% This function implements Spectral Clustering.
    W = getAdjacencyMatrix(data', 5);
    W = full(W);
    D = getDegreeMatrix(W);
    L = getNormalizedLaplacian(W, D);
    
    opts.tol = 1e-2;
    [V, ~] = eigs(L, k, 'sr', opts);
    idx = kmeans(V, k, 'Display', 'iter');
end