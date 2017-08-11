function [idx, n_queries, flag] = LandmarkClustering(S, k, q, delta, s_min)
    n = size(S, 1);
	iter = 4*k+16*log(1/delta);
    n_prime = floor(0.7*n);

    idx = zeros(n, 1);
	[L, n_queries] = LandmarkSelection(q, iter, S);
	[C, new_queries, flag] = ExpandLandmarks(k, s_min, n_prime, L, S);
    n_queries = n_queries + new_queries;
    if flag
        disp('No clustering found by Landmark Clustering. Try adjusting the parameters (especially s_min).')
        return;
    end
    % Choose some working landmark li from each cluster
    L = zeros(k, 1);
    for i = 1:k
        non_zeros = find(C == i);
        L(i) = non_zeros(randi(length(non_zeros)));
    end
    idx = zeros(n, 1);
	for i = 1:n
        min_dist = inf;
        for j = 1:size(L, 1)
            d = norm(S(i,:) - S(L(j),:));
            n_queries = n_queries + 1;
            if d < min_dist
                min_dist = d;
                best_l_index = j;
            end
        end
        idx(i) = best_l_index;
    end
end