%% This function predicts the labels the given model makes on the input
% You do not need to change this
function [predictions] = predictQ1(h, X)
% Input:  h - a scalar vector containinng the model [threshold]
%         X - a 1 by n vector containing the test instances
% Output: predictions - a 1 by n vector containing the predicted test labels
predictions = zeros(1,length(X));
for(i=1:length(X))
    if(X(i)>=h)
        predictions(i)=1;
    end
end
end