function [Gaug,daug] = AddSmoothnessConstraint_GMatrix(G,radcenters,d,smoothingweight)
% Add first derivative smoothing to G matrix
% assumes model param is layers. 
Gaug=G;
szs = size(Gaug);
gdim1=szs(1);
lend=length(d)
daug=d;
for ijk = 1:length(radcenters)-1
curr_row = zeros(size(radcenters));
curr_row(ijk)=smoothingweight;
curr_row(ijk+1)=-smoothingweight;
Gaug(gdim1+ijk,:) = curr_row;
daug(lend+ijk) = 0;
end

end