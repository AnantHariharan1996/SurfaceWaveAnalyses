%% Plot example of dcoverc at -117,42.5
clear;

pixlon =-117;

pixlat =42.5000;
USE_ALLUSANTData=1;
[periodlist,SR17PhVelList,measuredPhVelList,dcoverc] = Getdcoverc(pixlon,pixlat,USE_ALLUSANTData);

figure(1)
plot(periodlist,dcoverc,'-ro','linewidth',3)
hold on
USE_ALLUSANTData=0;
[periodlist,SR17PhVelList,measuredPhVelList,dcoverc] = Getdcoverc(pixlon,pixlat,USE_ALLUSANTData);
plot(periodlist,dcoverc,'-ko','linewidth',3)
xlabel('Period (s)')
ylabel('dc/c')
set(gca,'fontsize',18)
legend('USANT15 Data at Overlapping Periods','All of Our Data')
title(['Lon = ' num2str(pixlon) ', Lat = ' num2str(pixlat)])
set(gcf,'position',[476 403 514 463])
saveas(gcf,'ExamplePlot.jpg')

figure(2)
plot(periodlist,SR17PhVelList,'linewidth',3)
hold on
plot(periodlist,measuredPhVelList,'linewidth',3)
xlabel('Period (s)')
ylabel('c (km/s)')
set(gca,'fontsize',16)
legend('SR17 Predicted','Measured')
