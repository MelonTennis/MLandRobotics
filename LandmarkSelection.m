function [L, n_queries] = LandmarkSelection(q, iter, S)
    rng(0);
    iter = floor(iter);
    q = floor(q);
    L = zeros(iter, 1);
	% Choose l in S uniformly at random;
    n = size(S, 1);
    l = randi(n);
	L(1) = l;
    [d_min, n_queries] = query(l, S);
	for i = 1:(iter-1)
		%%%
        % Fill in here
        %%%
        [tmp, ind] = sort(d_min);
        s = S(ind);
        l1 = randi([n-q+1, n]);
        l1 = ind(l1);
        L(i+1) = l1;
        [d_new, n_qnew] = query(l1, S);
        n_queries = n_queries + n_qnew;
        for j = 1:size(d_new, 1)
            if d_new(j) < d_min(j)
                d_min(j) = d_new(j);
            end
        end
    end
end