function [Gaug,daug] = DampBottoms2StartingModel_Gmatrix(G,radcenters,d,dampingweight,lowestrad)
% At all the depths below the threshold depth, damp the model parameters to
% the starting model. 
Gaug = G;
szs = size(Gaug);
gdim1=szs(1);
lend=length(d)
daug=d;
idx = find(radcenters<lowestrad*1000);

for ijk = 1:length(idx)
    curr_row = zeros(size(radcenters));
    daug(lend+ijk) = 0;
    curr_row(idx(ijk)) = dampingweight;
    Gaug(gdim1+ijk,:) = curr_row;
end


end