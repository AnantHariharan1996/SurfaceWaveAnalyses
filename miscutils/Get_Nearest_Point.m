function [closestlon,closestlat,closestidx] = Get_Nearest_Point( StartLon,StartLat,LonList,LatList )
% Given a single Lat/Lon point and a second list of points to consider,
% find the point from the list closest to the input lat lon point. 
[ARCLEN, AZ] = distance(StartLat,StartLon,LatList,LonList);
mindist = min(ARCLEN);
closestidx = find(ARCLEN == mindist);
closestidx = closestidx(1);
closestlon = LonList(closestidx);
closestlat = LatList(closestidx);
end

