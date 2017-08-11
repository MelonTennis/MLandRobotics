
function [weights,errors] = winnow(data, labels)

%% Simulate the Winnow algorithm
% Inputs: data - an n by m matrix where n is the number of instances and m is the number of features
%         labels - a 1 by n vector containing the labels for the instances.
% Output: weights - a 1 by m vector of weights for each feature. large values mean more relevant
%         errors - a scalar indicating the total number of errors made by the classifier

% n = size(data, 1);
% m = size(data, 2);
weights = ones(1,size(data,2));
theta = size(data,2)/2; % this is the decision threshold.
errors = 0;
for(i=1:size(data,1))
    
    %% IMPLEMENT THE WINNOW ALGORITHM HERE
    if sum(weights.*data(i,:)) >= theta
        predition = 1;
    else 
            predition = 0;
    end
    if predition ~= labels(i)
            errors = errors +1;  
            if predition == 1
                weights = weights.*(abs(data(i,:) - labels(i))*(-0.5)+1);
            else if predition == 0
                  weights = weights.*(data(i,:)+1);
                end
            end
    end    
end

end