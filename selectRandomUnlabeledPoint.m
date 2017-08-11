function xr = selectRandomUnlabeledPoint(R)
% Added by MT (originally and currently exists in 'runExperimentsQ2.m'

UR = find(R==0); % get unlabeled points (random learning)
xr = UR(randi(length(UR)));
end
