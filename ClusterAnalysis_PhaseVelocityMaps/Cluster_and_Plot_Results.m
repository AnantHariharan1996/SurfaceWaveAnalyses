%% Do clustering and plot results
% try k values from 2 to 10


for k = 2:1:11 

close all
cmapppp = jet(k);
idx = kmeans(PhVel_SummaryMat,k);

figure()
subplot(1,2,1)
scatter(CommonLons,CommonLats,10,idx,'filled')
colormap(cmapppp);
barbar=colorbar;
ylabel(barbar,'Cluster Number')
title([num2str(k) ' Clusters'])
set(gca,'fontsize',16)

subplot(1,2,2)
for clustnum = 1:k
    tempdx = find(clustnum == idx);
    for currdx = tempdx
        plot(periodlist,PhVel_SummaryMat(currdx,:),'color',[ cmapppp(clustnum,:) 0.1],'linewidth',0.1)
    hold on
    
    end
end
xlabel('Period (s)')
ylabel('Phase Velocity (m/s)')
set(gca,'fontsize',16)
set(gcf,'position',[-8 426 1221 318])
xlim([min(periodlist)-5 max(periodlist)+5])
saveas(gcf,['SummaryFigs/LoveWavesClusteranalysisSummary_' num2str(k) 'clusters.jpg'])


end