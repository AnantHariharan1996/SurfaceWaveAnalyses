function [ gdmverr_list,gdmval_list ] = Get_Error_WrtGDM52( LonMap,LatMap,PhVel,RorL,Period )
% Gets error of an input phase velocity map wrt GDM52
% At every pixel, calculate the error with respect to the closest value in
% the GDM52 Map (Ekstrom 2011).
% Note that the period of interest MUST be...
% 30 35 40 50 60 75 100 125 150 200 250
% Note also that your PhVel input must be in units of m/s!
if RorL ~= 1 && RorL ~= 0
    
    disp('RorL MUST be 1 or 0. 1 is for Rayleigh, 0 is for Love!')
    
end

GDMperiodRefvec = [25 30 35 40 45 50 60 75 100 125 150 200 250];

Period_dx = find(Period == GDMperiodRefvec);
if length(Period_dx) == 0
    
   disp('The period you entered is not in the database.') 
    
end



load('LonLat_GDM52.mat')
GDMLons = LonLat(:,1);
GDMLats = LonLat(:,2);




if RorL == 1
    
    load('Rayleigh_GDM52_allPeriod.mat')
    Phvels = zzz;
    
elseif RorL == 0
    
    load('Love_GDM52_allPeriod.mat')
    Phvels = yyy;
    
end

idx = find(GDMLons > min(LonMap)-1 & GDMLons < max(LonMap)+1 ...
& GDMLats > min(LatMap)-1 & GDMLats < max(LatMap)+1);

GDMLons = GDMLons(idx);
GDMLats = GDMLats(idx);  
GDMc = Phvels(idx,Period_dx);  

gdmval_list = zeros(size(LonMap));
gdmverr_list = gdmval_list;
for ijk = 1:length(LonMap)
    
    distlist = distance(LatMap(ijk),LonMap(ijk),GDMLats,GDMLons);
    [mindist,mindx] = min(distlist);
    gdmval_list(ijk) = GDMc(mindx(1));
    gdmverr_list(ijk) = PhVel(ijk)-gdmval_list(ijk);
    
    
end

    
    
    
end



