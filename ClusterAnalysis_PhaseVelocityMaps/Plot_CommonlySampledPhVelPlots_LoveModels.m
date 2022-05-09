% Read in Phvel Map Data as a Matrix, sampled at the same points

%clear; clc; 
periodlist = [35 40 45 50 60 75];
    pcounter=0;

for period = periodlist
    pcounter=    pcounter+1;
figure(1)
subplot(2,3,pcounter)
scatter(CommonLons,CommonLats,5,PhVel_SummaryMat(:,pcounter),'filled')
colormap(flipud(turbo))
title([num2str(period) 's'])
colorbar

end
saveas(gcf,'PhVelMaps_AllPeriods_Love.jpg')
close all
