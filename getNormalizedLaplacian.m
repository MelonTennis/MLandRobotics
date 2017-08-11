function L = getNormalizedLaplacian(W, D)
    % Calculates the Normalized Laplacian for an adjacency matrix W
    % and degree matrix D
    W = full(W);
    D(D==0) = eps; % avoid dividing by zero
    L = zeros(size(W, 1), size(W, 2));
    % Calculate L here
    L1 = D - W;
    L = inv(D)*L1;
end