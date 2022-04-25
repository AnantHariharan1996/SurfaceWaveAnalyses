% Read in Phvel Map Data as a Matrix, sampled at the same points

%clear; clc; 
addpath('ggge21855-2018gc008073_data_set_s1')
periodlist = [25 40 50 60 80 100 120 140 180];
    pcounter=0;

for period = periodlist
    pcounter=    pcounter+1;
figure(1)
subplot(3,3,pcounter)
scatter(CommonLons,CommonLats,5,PhVel_SummaryMat(:,pcounter),'filled')
colormap(flipud(turbo))
title([num2str(period) 's'])
colorbar

end
saveas(gcf,'PhVelMaps_AllPeriods.jpg')
close all
