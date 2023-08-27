function [ttime_field_perturbed,tau,ttime_field_noscatter,R_forgrid,x_forgrid,Q] = ...
    Get_GaussianBeam_Phase_Delay(Period,evla,evlo,...
    scatterlat,scattererlon,taumax,L,GridLat,GridLon,cglb)
% 
% AH, 2023

% 
[alen,az] = distance(evla,evlo,scatterlat,scattererlon);
[ev2grid_dist,evgridaz] = distance(evla,evlo,GridLat,GridLon);
counter=0;

% set up great circle path
[tracklat,tracklon] = track1(evla,evlo,az,180,[],[],1000);
xlist= distance(scatterlat,scattererlon,tracklat,tracklon);

% for every point on the grid, get the perpendicular distance, 
% and R and X coord system
for ijk = 1:length(GridLon)  
    distlist = distance(tracklat,tracklon,GridLat(ijk),GridLon(ijk));
    [mindist,mindx]=min(distlist);
    % closest point is by definition perpendicular, right?
    x_forgrid(ijk) = deg2km(xlist(mindx));
    R_forgrid(ijk) = deg2km(mindist);  
end

% Build the Q term
Q1numerator = exp(1i*(2*pi/Period)*taumax)-1;
Q1denominator = sqrt((1i.*x_forgrid.*cglb.*Period)./(pi*L^2)+1);
Q2denominatornosqrt = ((1i.*x_forgrid.*cglb.*Period)./(pi*L^2))+1;
Q2 = exp(-1*((R_forgrid./L).^2)./(Q2denominatornosqrt));

Q = (Q1numerator./Q1denominator).*Q2;

% in seconds
tau = Period/(2*pi).*atan2(imag(1+Q),real(1+Q));

% find locations -behind- scatterer-.
% must set this to zero?

idx = find(ev2grid_dist < alen);
tau(idx)=0;
Q(idx)=0;

%%%%
[grid_dist,gridaz] = distance(evla,evlo,GridLat,GridLon);
[grid_dist_km] = deg2km(grid_dist);

% linear increase with distance
ttime_field_noscatter = grid_dist_km./cglb';

% build composite traveltime field
ttime_field_perturbed = ttime_field_noscatter+tau';


end

