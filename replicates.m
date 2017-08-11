function totalYield = replicates

%% run a replicate simulation for question 3
% Output: totalYield - the total ethanol yeild.

numgenes = 50;
numreplicates = 10;
rng(2016) % To ensure repeatable (i.e. grade-able) pseudorandom numbers

totalYield = 0;
%% IMPLEMENT ALGORITHM
for i = 1:numgenes
    for j = 1:numreplicates
        temp = RNAiSim(i);
        totalYield = totalYield + temp;
    end
end

end