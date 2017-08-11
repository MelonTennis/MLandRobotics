function [labeledsample, n_queries] = PLALlabeling(DATA, tree, epsilon, delta, TRUE_LABELS)
% INPUTS:   DATA - mxn data matrix acquired from either getSerumData or
%               getUrineData
%           tree - tree structure (either k-d or PCA) from make_tree
%           epsilon - PLAL parameter, set to 0.05
%           delta - PLAL parameter, set to 0.05
%           TRUE_LABELS - mx1 vector of labels acquired from getSerumData or
%               getUrineData
% OUTPUTS:  labeledsample - mx(n+1) data matrix where last column contains
%               the predicted labels
%           n_queries - scalar value of number of queries made by the algorithm


level = 0;
active_cells_currentlevel = [tree];
active_cells_nextlevel = [];
n_queries = 0;

% add vector of -1s to original sample set which will be changed to 0 or 1
% as labels
labeledsample = cat(2, DATA, -1*ones(length(DATA),1));

while ~isempty(active_cells_currentlevel)
    % IMPLEMENT PLAL ALGORITHM HERE
    
end