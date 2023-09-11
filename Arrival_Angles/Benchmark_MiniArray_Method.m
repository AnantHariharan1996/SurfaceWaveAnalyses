%% Solve for Arrival Angles 
%% Using a Mini-array approach

clear; clc; close all;
load coastlines
xlist= [-120:0.8:-80];
ylist= [28:0.8:48];
Phvel = 4;
%% Inputs
info = readtable('STAFILE_USARRAY.csv');
Sta_Lons = info.Var3;
Sta_Lats=info.Var2;
EvLon = [-150];
EvLat = [10];
distlist=distance(EvLat,EvLon,Sta_Lats,Sta_Lons);
distlist_km=deg2km(distlist);
L_Tol = 1;
TTime = distlist_km./Phvel;
Min_N_Stations=3;


%%

[ArrivalAngleList,Best_LocalPhVelList] = ...
    GetArrivalAngles_Event_MiniArray(Sta_Lons,Sta_Lats,TTime,L_Tol,EvLat,EvLon,Min_N_Stations)

figure(1)
subplot(2,2,1)

