function [UniqueLons,UniqueLats,stackedc,stdevc,numvals ] = Stack_and_Make_PhaseVeloMap( lonlist,latlist,clist,DeltaT,Threshold )
%Stack phase velocity measurements at every pixel to form a composite phase
%velocity map
defaultval = 99999999;
% Takes in 3 vectors,lon lat and c, on a regular grid, and stacks
zzz(:,1) = lonlist;
zzz(:,2) = latlist;
      LonLat =zzz(:,1:2);
   [uniquevals,uniquedx] = unique(LonLat,'rows');
  UniqueLons = uniquevals(:,1);
   UniqueLats = uniquevals(:,2);
   stackedc = defaultval*ones(size(UniqueLats));
   stdevc = defaultval*ones(size(UniqueLats));
   
   
for ijkl = 1:length(UniqueLats)
    currpixlon=UniqueLons(ijkl);
    currpixlat=UniqueLats(ijkl);
    pixdx = find(lonlist == currpixlon ...
        & latlist == currpixlat & DeltaT > Threshold);
    stackedc(ijkl) = median(clist(pixdx));
    stdevc(ijkl) = std(clist(pixdx));
    numvals(ijkl) = length(pixdx);
end


end

