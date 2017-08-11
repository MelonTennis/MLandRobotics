function [ C, flag ] = FormatClustering( U, items )
%FORMATCLUSTERING Summary of this function goes here
%   Detailed explanation goes here
C = zeros(length(U), 1);
for i = 1:size(U,1)
    for l = find(U(i,:))
        for s = find(items(l, :))
            C(s) = i;
        end
    end     
end
flag = 0;   % indicate success
end