%% Demonstrate Overtone interference for Arrival Angles
addpath(genpath('/Users/ahariharan/Documents/GitHub/SurfaceWaveAnalyses/'))
clear; clc; close all;

Period = 50;
L_Tol = 1;
Min_N_Stations=4;


cFName =  ['Ocean_LonLatAMEik' num2str(Period) 's'];
cInfo = load(cFName);

dtpFname = ['dtpamp_oceanAM' num2str(Period) 's'];
[ evla,evlo,stalat,stalon,tabs,nsamp,amp ] = Read_dtpamp_file( dtpFname );
EvLat=evla(1);
EvLon=evlo(1);

[ArrivalAngleList,Best_LocalPhVelList] = ...
    GetArrivalAngles_Event_MiniArray(stalon,stalat,tabs,L_Tol,EvLat,EvLon,Min_N_Stations)


figure(1)
subplot(1,2,1)
scatter(cInfo(:,1),cInfo(:,2),50,cInfo(:,3),'filled')

subplot(1,2,2)
scatter(stalon,stalat,50,ArrivalAngleList,'filled')
