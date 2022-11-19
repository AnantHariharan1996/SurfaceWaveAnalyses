clear; clc; close all;

% this script will do a little grid search to demonstrate sensitivities
depths = [0 10 10.1 20 30 40 40.01 50 60 70 80 90 100];
vsh = [1000 1000 3000 3000 3000 3000 4200 4200 4200 4200 4200 4200 4200];

% depths = [0 10 20 30];
% vsh = linspace(100,4000,4);
[ncard,premcard] = Generate_VSH_Mineos_Mod_PREMBackground(depths,vsh)
[FM_Periods,FM_Phvel,ncard] = GetPredPhVel(depths,vsh)

figure()
subplot(1,2,1)
plot(ncard.vsh,ncard.z,'linewidth',2)
set(gca,'ydir','reverse')
ylim([0 80])
xlabel('vsh (m/s)')
ylabel('depth (km)')

%%% 
%%%
subplot(1,2,2)
plot(FM_Periods,FM_Phvel)