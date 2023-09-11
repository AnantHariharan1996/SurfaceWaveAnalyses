% July 15, AH
clear; close all; clc; 

addpath(genpath(pwd))
figure()
ax = worldmap('World');
setm(ax, 'Origin', [0 0 0])
load coastlines
hold on
ridge=loadjson('ridge.json');
ridge_info = ridge{2};
plotm(coastlat,coastlon,'k','LineWidth',2,'color',[0 0 0])
plotm(ridge_info(:,2),ridge_info(:,1),'k','LineWidth',2,'color',[1 0 0])
trench=loadjson('trench.json');
trench_info = trench{2};
plotm(trench_info(:,2),trench_info(:,1),'k','LineWidth',2,'color',[0 1 0])
transform=loadjson('transform.json');
transform_info = transform{2};
plotm(transform_info(:,2),transform_info(:,1),'k','LineWidth',2,'color',[0 0 1])
set(gca,'fontsize',14)
setm(gca,'grid','off')
setm(gca,'meridianlabel','off')
setm(gca,'parallellabel','off')