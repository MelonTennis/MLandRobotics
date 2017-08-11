function [ ] = runExperimentsQ3()
%RUNEXPERIMENTSQ3 Runs LandmarkClustering, Spectral Clustering, and K-means
% clustering on the real dataset.
    k = 5;
    [data, idx_true] = getDataForQ3();
    addpath('../Q1')
    addpath('../Q2')
    delta = 0.5;
    s_min = 1;
    q = 90;
    [idx_landmark, n_queries, flag] = LandmarkClustering(data, k, q, delta, s_min);
    fprintf('Landmark Clustering queries %d\n', n_queries)
    idx_spectral = SpectralClustering(data, k);
    idx_kmeans = kmeans(data, k, 'Display', 'iter');
    [~, data, ~] = pca(data);
    Colors = hsv(k);

    % Plot LandmarkClustering
    if ~flag
        hold on
        for i = 1:k
            scatter(data(idx_landmark == i, 1), data(idx_landmark == i, 2), 36, Colors(i,:), '+')
        end
        title('Landmark Clustering')
        legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5')
        xlabel('Principal Component 1')
        ylabel('Principal Component 2')
        hold off
    end
    
    
    % Plot SpectralClustering
    figure
    hold on
    for i = 1:k
        scatter(data(idx_spectral == i, 1), data(idx_spectral == i, 2), 36, Colors(i,:), '+')
    end
    title('Spectral Clustering')
    legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5')
    xlabel('Principal Component 1')
    ylabel('Principal Component 2')
    hold off
    
    % Plot Kmeans Clustering
    figure
    hold on
    for i = 1:k
        scatter(data(idx_kmeans == i, 1), data(idx_kmeans == i, 2), 36, Colors(i,:), '+')
    end
    title('Kmeans Clustering')
    legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5')
    xlabel('Principal Component 1')
    ylabel('Principal Component 2')
    
    % Plot Ground Truth
    hold off
    figure
    hold on
    data(idx_true == 3)
    for i = 1:k
        scatter(data(idx_true == i, 1), data(idx_true == i, 2), 36, Colors(i,:), '+')
    end
    title('Ground Truth')
    legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5')
    xlabel('Principal Component 1')
    ylabel('Principal Component 2') 
end