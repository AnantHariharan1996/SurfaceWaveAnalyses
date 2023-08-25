clear; clc; close all;
% Explore the period limit
depths = [0:10:100];
vsh = linspace(3200,4300,length(depths));
[ncard,premcard] = Generate_VSH_Mineos_Mod_PREMBackground(depths,vsh);
figure()
subplot(1,2,1)
plot(premcard.vsh,premcard.z,'-o','linewidth',2)
set(gca,'ydir','reverse')
ylim([0 250])
hold on
plot(ncard.vsh,ncard.z,'-o','linewidth',2)

subplot(1,2,2)
plot(premcard.vsv,premcard.z,'-o','linewidth',2)
set(gca,'ydir','reverse')
ylim([0 250])
hold on
plot(ncard.vsv,ncard.z,'-o','linewidth',2)



[FM_Periods,FM_Phvel,ncard] = GetPredPhVel(depths,vsh)
figure()
plot(FM_Periods,FM_Phvel,'-o','linewidth',2)
xlabel('Period (s)')
ylabel('Love Wave Phvel (km/s)')