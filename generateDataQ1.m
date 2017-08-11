%% This function generates the data for this question.
function [DATA, TRUE_LABELS,TRUE_THRESHOLD] = generateDataQ1(numsamples,noise)
% Input:  numsamples - the number of samples to generate
%         noise - a number in the range (0,1) to determine which percentage
%         of the data are noise
% Output: DATA - a 1 by numsamples vector of random numbers in [0,1]
%         TRUE_LABELS - a 1 by numsamples vector of labels (0 or 1)
%         TRUE_THRESHOLD  - a scalar containing the true threshold
TRUE_THRESHOLD = .6;
TRUE_LABELS = zeros(1,numsamples);
DATA = rand(1,numsamples);
TRUE_LABELS(find(DATA>=TRUE_THRESHOLD))=1;
if(noise>0)
   for(i=1:length(DATA))
      if(rand<noise)
          TRUE_LABELS(i) = abs(1 - TRUE_LABELS(i));
      end
   end
end
end