function [ ] = runExperimentsQ2()
%RUNEXPERIMENTSQ2 Main function to run and plot results for the synthetic dataset.
    rng(0)
    k = 2;
    [data, idx_true] = getDataForQ2();
    fprintf('Dataset size %d\n', size(data, 1))
    s_min = 600;
    delta = 0.05;
    q = 1000;
    disp('Running Landmark Clustering')
    [idx_landmark, n_queries] = LandmarkClustering(data, k, q, delta, s_min);
    fprintf('Landmark Clustering queries %d\n', n_queries)
    addpath('../Q1')
    disp('Running Spectral Clustering')
    idx_spectral = SpectralClustering(data, k);
    disp('Running Kmeans Clustering')
    idx_kmeans = kmeans(data, k, 'Display', 'iter');
    
    Colors = hsv(k);
    hold on
    for i = 1:k
        scatter(data(idx_landmark == i, 1), data(idx_landmark == i, 2), 36, Colors(i,:), '+')
    end
    title('Landmark Clustering')
    legend('Cluster 1', 'Cluster 2')
    hold off
    
    figure
    hold on
    for i = 1:k
        scatter(data(idx_spectral == i, 1), data(idx_spectral == i, 2), 36, Colors(i,:), '+')
    end
    title('Spectral Clustering')
    legend('Cluster 1', 'Cluster 2')
    hold off
    
    figure
    hold on
    for i = 1:k
        scatter(data(idx_kmeans == i, 1), data(idx_kmeans == i, 2), 36, Colors(i,:), '+')
    end
    title('Kmeans Clustering')
    legend('Cluster 1', 'Cluster 2')
    hold off
    
    figure
    hold on
    for i = 1:k
        scatter(data(idx_true == i, 1), data(idx_true == i, 2), 36, Colors(i,:), '+')
    end
    title('Ground Truth')
    legend('Cluster 1', 'Cluster 2')
end