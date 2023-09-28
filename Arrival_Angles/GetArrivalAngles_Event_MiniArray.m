function [ArrivalAngleList,Best_LocalPhVelList] = ...
    GetArrivalAngles_Event_MiniArray(Sta_Lons,Sta_Lats,TTime,L_Tol,EvLat,EvLon,Min_N_Stations)
% Uses the Foster 2014 method for every station with a traveltime
% measurement for an earthquake to measure arrival angles

distlist=distance(EvLat,EvLon,Sta_Lats,Sta_Lons);
distlist_km=deg2km(distlist);


for ijk = 1:length(Sta_Lats)
100*ijk/length(Sta_Lats)
curr_stalat=  Sta_Lats(ijk);
curr_stalon=  Sta_Lons(ijk);
% Get arrival angle assuming plane wave as 
% a starting estimate. 
[alen,azimuthstart] = distance(EvLat,EvLon,curr_stalat,curr_stalon);
searchaz=azimuthstart-40:0.25:azimuthstart+40;
% Get mini-array;
dists2otherstns = distance(curr_stalat,curr_stalon,Sta_Lats,Sta_Lons);
idx=find(dists2otherstns<L_Tol);
if length(idx) > Min_N_Stations

arraylats=Sta_Lats(idx);
arraylons=Sta_Lons(idx);
arrayttimes=TTime(idx);

[Best_Angle,Best_LocalPhVelList(ijk),Misfitlist] = ...
    GetArrivalAngle_MiniArraySingleStation(arraylons,arraylats,curr_stalon,curr_stalat,arrayttimes,searchaz,alen);

ArrivalAngleList(ijk) = Best_Angle;
else
ArrivalAngleList(ijk) = NaN;
Best_LocalPhVelList(ijk) = NaN;

end

end




end