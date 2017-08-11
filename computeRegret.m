function [regret,modelLoss] = computeRegret(modelPredictions, alternativePredictions, labels)

%% Compute the instantaneous regret given model's predictions up to time t; the predictions made by an alternative set of models; the true labels.
% Inputs: modelPredictions - this is a 1 by t vector giving the predictions made by the model over the first t iterations
%         alternativePredictions - this is an n by t matrix containing the predictions made by an alternative set of n models over the first t iterations
%         labels - this is an 1 by t vector containing the true labels
% Outputs: regret - the instantaneous regret at iteration t
%          modelLoss - the instantaneous loss at iteration t

%% IMPLEMENT REGRET CALCULATION HERE
n = size(alternativePredictions,1);
t = size(alternativePredictions,2);
alterLoss = zeros(1, n); % loss
bestLoss = squaredErrorLoss(alternativePredictions(1,:), labels);
for i = 1:n
    alterLoss(i) = squaredErrorLoss(alternativePredictions(i,:), labels);
    if bestLoss > alterLoss(i)
        bestLoss = alterLoss(i);
    end
end
regret = squaredErrorLoss(modelPredictions, labels)-bestLoss;
modelLoss = squaredErrorLoss(modelPredictions, labels);

