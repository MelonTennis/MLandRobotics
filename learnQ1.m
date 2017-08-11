%% This function learns a threshold function on the unit interval from training data
% You do not need to change this
function [h flag] = learnQ1(X,Y)
% Input:  X - a 1 by n vector containing the training instances
%         Y - a 1 by n vector containing the training labels
% Output: h - a scalar containinng the model [threshold]. everthing above
% this threshold is labeld 1
%         flag - a scalar that is 0 if the algorithm succeeds, 1 otherwise
flag = 1;
h = 1; % default model is that everything is labeled 0

h = min(X(Y==1)); %left-most point labeld 1
if(isempty(h)==1)
    h=1;
    flag = 0;
    return
else
    h2 = max(X(Y==0)); %right-most point labeld 0
    flag = 0;
    if(h2>h)
        flag=1;
        h=1;
        return
    end
end
end