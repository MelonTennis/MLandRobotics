%% ABR_HW3Q2B
[genomes, labels] = getDataForQuestion2;
[weights,errors] = winnow(genomes, labels);
figure
plot(weights);
xlabel('genomes');
ylabel('weights');
