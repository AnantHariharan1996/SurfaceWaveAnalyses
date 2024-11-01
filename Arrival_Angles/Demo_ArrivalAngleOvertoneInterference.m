%% Demonstrate Overtone interference for Arrival Angles
addpath(genpath('/Users/ahariharan/Documents/GitHub/SurfaceWaveAnalyses/'))
clear; clc; close all;

Period = 50;
L_Tol = 1;
Min_N_Stations=4;


cAM_Name =  ['Ocean_LonLatAMEik' num2str(Period) 's'];
cAMInfo = load(cAM_Name);
cFM_Name =  ['Ocean_LonLatFMEik' num2str(Period) 's'];
cFMInfo = load(cFM_Name);

dtpAMname = ['dtpamp_oceanAM' num2str(Period) 's'];
[ evlaA,evloA,stalatA,stalonA,tabsA,nsampA,ampA ] = Read_dtpamp_file( dtpAMname );
EvLatA=evlaA(1);
EvLonA=evloA(1);

dtpFMname = ['dtpamp_oceanFM' num2str(Period) 's'];
[ evlaF,evloF,stalatF,stalonF,tabsF,nsampF,ampF ] = Read_dtpamp_file( dtpFMname );
EvLatF=evlaF(1);
EvLonF=evloF(1);


figure(2)
[ fxA,fyA,angleA,xgridA,ygridA,tgrid2A ] = Get_arrival_angle(stalatA,stalonA,tabsA,0.25 );
[ fxF,fyF,angleF,xgridF,ygridF,tgrid2F ] = Get_arrival_angle(stalatF,stalonF,tabsF,0.25 );

%%%
figure()
subplot(1,2,1)
scatter(xgridA,ygridA,20,angleA-angleF,'filled')
caxis([-10 10])
barbr=colorbar;
title('Difference Between All-Mode and Fundamental Mode Arrival Angles')
ylabel(barbr,'Arrival Angle Residual (degrees)')
set(gca,'fontsize',20,'fontweight','bold')
load coastlines
hold on
plot(coastlon,coastlat,'linewidth',2,'color','k')
xlim([-130 -70])
ylim([25 50])
box on; grid on;
subplot(1,2,2)
scatter(cAMInfo(:,1),cAMInfo(:,2),50,100*(cAMInfo(:,3)-cFMInfo(:,3)),'filled')
caxis([-250 250])
barbr=colorbar;
load coastlines
hold on
plot(coastlon,coastlat,'linewidth',2,'color','k')
title('Difference Between All-Mode and Fundamental Mode Phase Velocities')
ylabel(barbr,'Eikonal Phase Velocity Difference (m/s)')
colormap(jet)
set(gca,'fontsize',20,'fontweight','bold')
set(gcf,'position',[108 627 1661 371])
xlim([-130 -70])
ylim([25 50])
box on; grid on;
set(gcf,'position',[108 594 2087 404])


saveas(gcf,'OvertoneIntComparison_PhVel_ArrivalAngle.jpg')
saveas(gcf,'OvertoneIntComparison_PhVel_ArrivalAngle.png')
