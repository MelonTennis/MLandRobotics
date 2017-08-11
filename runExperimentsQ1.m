function [ ] = runExperimentsQ1()
%RUNEXPERIMENTSQ1 Main function to run and plot results for the synthetic dataset.
    %rng(0); % yazhi gao found that with rng(10) spectral clustering works well
    k = 2;
    [data, idx_true] = getDataForQ1();
    disp('Running Spectral Clustering')
    idx_spectral = SpectralClustering(data, k);
    disp('Running K-means Clustering')
    idx_kmeans = kmeans(data, k, 'Display', 'iter');
    Colors = hsv(k);
    
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