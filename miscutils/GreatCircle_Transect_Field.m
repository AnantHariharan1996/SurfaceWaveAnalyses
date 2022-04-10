function [ raypath_dist,Val_matched,raylon_matched,raylat_matched ] = GreatCircle_Transect_Field( StartLocx,StartLocy,EndLocx,EndLocy,x,y,z,Polylon,Polylat,PolyOn,ArclenThresh )
% Extracts transect of points of a vector field along a specific transect. 
[ARCLEN, AZ1] = distance(StartLocy,StartLocx,EndLocy,EndLocx);
[latgc1,longc1] = track1('gc',StartLocy,StartLocx,AZ1);
latgc1 = interp(latgc1,10);
longc1 = interp(longc1,10);

defval('ArclenThresh',1);  
Arclen_Thresh = ArclenThresh;

if PolyOn
[in,on] = inpolygon( longc1,latgc1,Polylon,Polylat);   % Logical Matrix
inon = in | on;     % Combine ?in? And ?on?
idx = find(inon(:));  

Approx_Ray_lon = longc1(idx);
Approx_Ray_lat = latgc1(idx);
else
Approx_Ray_lon = longc1;    
Approx_Ray_lat = latgc1;
end

% Approx_Ray_lon = interp(Approx_Ray_lon,20,2)
% Approx_Ray_lat = interp(Approx_Ray_lat,20,2)

raylon_matched = [];
raylat_matched = [];
rayamp_matched = [];

for i = 1:length(Approx_Ray_lon)
    
    currlon = Approx_Ray_lon(i);
    currlat = Approx_Ray_lat(i);
    [ARCLEN, AZ] = distance(y,x,currlat,currlon);
    mindistidx = find(ARCLEN < Arclen_Thresh);
    raylat_matched = [raylat_matched y(mindistidx)];
    raylon_matched = [raylon_matched x(mindistidx)];
    rayamp_matched = [rayamp_matched z(mindistidx)];

end

start_raylon = Approx_Ray_lon(1);
start_raylat = Approx_Ray_lat(1);

[raypath_dist] = distance(StartLocy,StartLocx,raylat_matched,raylon_matched);

Val_matched = rayamp_matched;

% scatter(raypath_dist,rayamp_matched,30,'r','filled')
% grid on
% box on
% title ('Plot of Amplitude ~Along GC Path: AWSMS')
% xlabel('Distance along Great Circle')
% ylabel('Amplitude')


end

