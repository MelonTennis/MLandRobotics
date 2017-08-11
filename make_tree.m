function [tree] = make_tree(DATA,split_function,params)
% example command: kdtree = make_tree(data, @split_KD);
% 
%   INPUTS: DATA - mxn matrix of the data you want to put into a tree
%           split_function - for a k-d tree, use "@split_KD", and for a PCA
%                           tree, use "@split_PCA"
%           params - leave blank
%   OUTPUT: tree - tree structure containing the following fields:
%               idxs - the row indices from DATA of all children of the node
%               left - a structure containing the left child
%               right - a structure containing the right child
%               split_dir - vector representing the direction of splitting
%                   for this node
%               threshold and proj_data are not needed for this
%               assignment - please see the paper on partition trees if
%               you'd like to know more about these values.
% 


if nargin < 2;  split_function = @split_PCA; end
if nargin < 3;  params = []; end
if ~isfield(params,'MAX_DEPTH'); params.MAX_DEPTH = 15; end
if ~isfield(params,'split_fxn_params');  
    split_fxn_params.spill = 0;
    params.split_fxn_params = split_fxn_params;
end

tree = create_tree(DATA,1:size(DATA,1),split_function,params.split_fxn_params, params.MAX_DEPTH,1);



function [tree] = create_tree(DATA,idxs,split_function,split_fxn_params, MAX_DEPTH,curr_depth)

tree.idxs = idxs;
tree.left = [];
tree.right = [];
tree.threshold = NaN;
tree.split_dir = NaN;
tree.proj_data = [];

if curr_depth >= MAX_DEPTH; return; end;
if length(idxs)<=1; return; end;

[idx_left, idx_right, threshold, split_dir, proj_data] = split_function(DATA(idxs,:), split_fxn_params);
left_idxs = idxs(idx_left);
right_idxs = idxs(idx_right);

tree.left  = create_tree(DATA,left_idxs ,split_function,split_fxn_params,MAX_DEPTH,curr_depth+1);
tree.right = create_tree(DATA,right_idxs,split_function,split_fxn_params,MAX_DEPTH,curr_depth+1);

tree.threshold = threshold;
tree.split_dir = split_dir;
tree.proj_data = proj_data;
