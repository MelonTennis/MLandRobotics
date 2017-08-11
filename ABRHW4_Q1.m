%% Automation of Biological Research Homework number 4, question 1, Fall 2015
% Authors:  Christopher James Langmead;
% Version: 0.2
% Date: 10/09/2015
% Description
% This file contains the stub code for the first question of the fourth homework.

%% This function runs the algorithm (runCAL) 10 times and plots the results
% You do not need to change this
function ABRHW4_Q1(noise)
% Input:  noise - a number in the range [0,1) to determine the probability that the oracle returns the wrong label

if(nargin == 0)
    noise = 0;
end

% store the error curves
numtrials = 25;
CAL_ERRORS=zeros(numtrials,50); % CAL's generalization errors
RND_ERRORS=zeros(numtrials,50); % random learner's generalization errors

% run the algorithm numtrials times
for(i=1:numtrials)
    [CALGeneralizationError, RandGeneralizationError] = runExperimentsQ1_SOLN(noise);
    CAL_ERRORS(i,1:length(CALGeneralizationError))=CALGeneralizationError;
    RND_ERRORS(i,1:length(RandGeneralizationError))=RandGeneralizationError;
    
    % copy last error to the end so that we can compute means properly
    CAL_ERRORS(i,1+length(CALGeneralizationError):end)=CALGeneralizationError(end);
    RND_ERRORS(i,1+length(RandGeneralizationError):end)=RandGeneralizationError(end);
end
CAL_AV_ERRORS = zeros(1,50);CAL_ST_ERRORS = zeros(1,50);
RND_AV_ERRORS = zeros(1,50);RND_ST_ERRORS = zeros(1,50);

for(i=1:size(CAL_AV_ERRORS,2))
    CAL_AV_ERRORS(i) = mean(CAL_ERRORS(:,i));
    CAL_ST_ERRORS(i) = std(CAL_ERRORS(:,i))/sqrt(numtrials);
    RND_AV_ERRORS(i) = mean(RND_ERRORS(:,i));
    RND_ST_ERRORS(i) = std(RND_ERRORS(:,i))/sqrt(numtrials);
end
errorbar(CAL_AV_ERRORS,CAL_ST_ERRORS);
hold on
errorbar(RND_AV_ERRORS,RND_ST_ERRORS,'r');
hold off
legend('CAL','Random')
xlabel('Number of Queries');
ylabel('Generalization Error');
end