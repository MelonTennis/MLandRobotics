function totalYield = bandit

%% run a multi-armned bandit simulation for question 3
% Output: totalYield - the total ethanol yeild.

numgenes = 50;
numreplicates = 10;
rng(2016) % To ensure repeatable (i.e. grade-able) pseudorandom numbers

mu = zeros(1, numgenes);
times = ones(1, numgenes);
sigma = zeros(1, numgenes);
yield = zeros(numgenes, numgenes*numreplicates);
totalYield = 0;
%% IMPLEMENT ALGORITHM
for j = 1: numgenes
    yield(j,1) = RNAiSim(j);
    mu(j) = yield(j,1);
end
UCB = mu + 1.96*(sigma/sqrt(1));
totalYield = totalYield + sum(sum(yield));
temp = 0;
for i = 1:450
    [maxV, maxI] = max(UCB);
    temp = RNAiSim(maxI);
    times(maxI) = times(maxI)+1;
    yield(maxI,times(maxI)) = temp;
    mu(maxI) = mean(yield(maxI, 1:times(maxI)));
    sigma(maxI) = std(yield(maxI, 1:times(maxI)));
%     sigma(maxI) = sqrt(1/times(maxI)*sum((yield(maxI,1:times(maxI))-mu(maxI)).^2));
    UCB(maxI) = mu(maxI) + 1.96*(sigma(maxI)/sqrt(times(maxI)));
    totalYield = totalYield + temp;
end

end