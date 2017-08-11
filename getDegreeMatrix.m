function D = getDegreeMatrix(W)
    % Calculates the Degree Matrix for a given adjacency matrix
	D = zeros(size(W, 1), size(W, 2));
    [m, n] = size(D);
    for i = 1:m
        for j = i:n
          if(i == j)
              D(i,j) = sum(W(i,:));
          end
        end
    end
    % Fill in D here
end