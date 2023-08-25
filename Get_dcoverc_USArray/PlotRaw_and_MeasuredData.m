clear; clc; close all;
load('ModelInfo.mat')

MeasuredInfoexample = load('Love_phvel_50s');
MeasuredLon = MeasuredInfoexample(:,1);
MeasuredLat = MeasuredInfoexample(:,2);
USE_ALLUSANTData=0;
latlist = ModelInfo(1).latlist;
lonlist = ModelInfo(1).lonlist;
Periodlist = [12    15    20    25    30    35    40    45  50    60    75];


parfor ijk  = 1:length(MeasuredLon)
%     100*ijk/length(MeasuredLat)
distlist=distance(MeasuredLat(ijk),MeasuredLon(ijk),latlist,lonlist);
[mindist,mindx]=min(distlist);
currperiod = ModelInfo(mindx).tsecs;
currphvel = ModelInfo(mindx).phvel;
predictedphvel =  interp1(currperiod,currphvel,Periodlist);
[periodlist,PhVelList] = Get_USArray_Phvel(MeasuredLon(ijk),MeasuredLat(ijk),USE_ALLUSANTData,Periodlist);
StartingModelStore(ijk,:) = predictedphvel;
USArrayStore(ijk,:) = PhVelList;
dcovercstore(ijk,:)=(PhVelList-predictedphvel)./predictedphvel;
end

% do clustering and plotting;

figure(1)
k= 7;
cmappp= turbo(k);
measure_clusters=kmeans(USArrayStore,k,'MaxIter',10000);
for clustnum=1:k
  idx = find(measure_clusters == clustnum);
figure(1)
subplot(1,2,1)
plot(Periodlist,USArrayStore(idx,:),'color',[cmappp(clustnum,:) 0.075],'linewidth',0.1)
hold on
subplot(1,2,2)
scatter(MeasuredLon(idx),MeasuredLat(idx),50,cmappp(clustnum,:),'filled')
hold on
end

figure(1)
subplot(1,2,1)
xlabel('Period (s)')
ylabel('Phase Velocity (km/s)')
ylim([2.5 4.5])
set(gca,'fontsize',16,'fontweight','bold')
subplot(1,2,2)
xlabel('Longitude')
ylabel('Latitude')
set(gca,'fontsize',16,'fontweight','bold')



figure(2)
k= 7;
cmappp= parula(k);
measure_clusters=kmeans(StartingModelStore,k,'MaxIter',10000);
for clustnum=1:k
  idx = find(measure_clusters == clustnum);
figure(2)
subplot(1,2,1)
plot(Periodlist,StartingModelStore(idx,:),'color',cmappp(clustnum,:),'linewidth',0.1)
hold on
subplot(1,2,2)
scatter(MeasuredLon(idx),MeasuredLat(idx),50,cmappp(clustnum,:),'filled')
hold on
end

figure(2)
subplot(1,2,1)
xlabel('Period (s)')
ylabel('Phase Velocity (km/s)')
ylim([2.5 4.5])
set(gca,'fontsize',16,'fontweight','bold')
subplot(1,2,2)
xlabel('Longitude')
ylabel('Latitude')
set(gca,'fontsize',16,'fontweight','bold')
ylim([27 47])




figure(3)
k= 7;
cmappp= turbo(k);
measure_clusters=kmeans(dcovercstore,k,'MaxIter',10000)
for clustnum=1:k
  idx = find(measure_clusters == clustnum);
figure(3)
subplot(1,2,1)
plot(Periodlist,dcovercstore(idx,:),'color',[cmappp(clustnum,:) 0.075],'linewidth',0.1)
hold on
subplot(1,2,2)
scatter(MeasuredLon(idx),MeasuredLat(idx),50,cmappp(clustnum,:),'filled')
hold on
ylim([27 47])

figure(5)
subplot(3,3,clustnum)
plot(Periodlist,dcovercstore(idx,:),'color',[cmappp(clustnum,:) 0.075],'linewidth',0.1)
title(['Cluster ' num2str(clustnum)])
ylim([-0.02 0.06])
xlabel('Period (s)')
ylabel('dc/c')
set(gca,'fontsize',14,'fontweight','bold')
end

figure(3)
subplot(1,2,1)
xlabel('Period (s)')
ylabel('dc/c')
ylim([-0.02 0.06])
set(gca,'fontsize',16,'fontweight','bold')
subplot(1,2,2)
xlabel('Longitude')
ylabel('Latitude')
set(gca,'fontsize',16,'fontweight','bold')
ylim([27 47])
