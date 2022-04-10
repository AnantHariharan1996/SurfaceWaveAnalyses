function [lonlist,latlist] = Evenly_Space_Evts(NumPts,Radius,Centerlon,Centerlat)
% Defines points evenly spaced around a circle
Azilist = (360/NumPts):(360/NumPts):360;
Distance = 1000*deg2km(Radius);
[latlist,lonlist] = getDestinationLatLong(Centerlat,Centerlon,Azilist,Distance);

idx = find(lonlist > 180);
lonlist(idx) = lonlist(idx) - 360;

idx = find(latlist > 90);
latlist(idx) = latlist(idx) - 180;

idx = find(lonlist < -180);
lonlist(idx) = lonlist(idx) + 360;

idx = find(latlist < -90);
latlist(idx) = latlist(idx) + 180;


end

