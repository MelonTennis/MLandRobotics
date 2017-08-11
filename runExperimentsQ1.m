%% This function runs the CAL and random learner in parallel assuming a streaming data model
function [CALGeneralizationError, RandGeneralizationError] = runExperimentsCAL(noise)
% Input:  noise - a number in the range (0,1) to determine which percentage
%         of the data are noise
% Output: CALGeneralizationError - a vector containing the CAL's generalization error as a function of the number of calls to the oracle
%         RandGeneralizationError - a vector containing the random learner's generalization error as a function of the number of calls to the oracle

% This question involves implementing the CAL algorithm for learning an
% interval on the real line. Specifically, the algorithm will estimate the
% boundaries of an interval on the real line, I \subset [0,1], such that
% f(x) = 1 if x is in I, and f(x) = 0 if x is not in I.
%
% Additionally, you will implement a random learner for performing the
% same task and compare the performance of both algorithms
% 
% Read through the code carefully. The parts that you have to implement
% are labeled with comments, such as IMPLEMENT THIS


%% ALGORITHM PARAMETERS
numsamples = 1000;

% generate the data. DATA is a 1 by numsamples vector of values in the
% interval [0,1]. TRUE_LABELS is a 1 by numsamples vector of labels (either 0 or 1)
[DATA, TRUE_LABELS,TRUE_INTERVAL] = generateDataQ1(numsamples,noise);

% S is a binary vector indicating which samples have been queried by CAL
S = zeros(1,numsamples);

% SLabels is a vector containing the labels (whether inferred or queried)
SLabels = zeros(1,numsamples);

% R is a binary vector indicating which samples have been queried by the random learner
R = zeros(1,numsamples);

% RLabels is a vector containing the labels (whether inferred or queried)
RLabels = zeros(1,numsamples);

% these vectors keep track of the generalization errors for CAL and the random learner
% initial error is calculated assuming the default model predicts all 0's.
% Note that the generalization error is computed using all the data.
CALGeneralizationError(1) = sum(TRUE_LABELS)/numsamples; % compute generalization error
RandGeneralizationError(1) = sum(TRUE_LABELS)/numsamples; % compute generalization

% this loop simulates streaming data
cost = 0;  % keeps track of the number of calls to the oracle
for (i=1:numsamples)
    
    x = i; % get the next instance from the stream
    
    % *************** IMPLEMENT THIS   ***************** %
    % you will need to:
    %   (i) learn the appropriate models
    %   (ii) apply the logic of the CAL algorithm
    %   (iii) keep track of costs and errors
    %   (iv) implement a random learner. Note: an easy way to do this is to
    %   select a random point to label each time the algorithm selects one.
    %   The vector R can be used to keep track of the sampled labeled by
    %   the random learner
    
end

end
