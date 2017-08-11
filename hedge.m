function [regrets,modelLosses,weights] = hedge(data,labels,eta)

%% Simulate the Hedge Algorithm
% Inputs: data - an n by t matrix where n is the number of experts and t is the number of iterations of the algorithm
%         labels - a 1 by t vector containing the true labels for each of the t iteractions
%         eta - the learning rate, which is a value in (0,1)
% Outputs: regrets - a 1 by t vector containing the INSTANTANEOUS regrets for iterations 1 to t
%          modelLosses - a 1 by t vector containing the INSTANTANEOUS loss at iteration t
%          weights - a 1 by n vector containing the FINAL weights over the experts

% n = size(data,1)
% t = size(data,2)
weights = ones(1,size(data,1));  % n
modelPredictions = zeros(1,size(data,2)); % t
modelLosses = zeros(1,size(data,2)); % t
regrets = zeros(1,size(data,2)); % t

weights=weights/sum(weights); % 1/n
for i=1:size(data,2)  % t
%% IMPLEMENT MAIN LOOP OF HEDGE HERE
   random = mnrnd(1, weights);
   ranModel = random*data;
   modelPredictions(i) = ranModel(i);
   weights = weights.*(eta).*exp(-1*abs(transpose(data(:,i))-labels(i)));
   [regrets(i),modelLosses(i)] = computeRegret(modelPredictions(1:i), data(:,1:i), labels(1:i));
   weights=weights/sum(weights); % re-normalize weights
end

end