clear; clc; close all;
phvel=4;
lonlist=linspace(-120,-70,100);
latlist=linspace(20,50,100);
[XX,YY] = meshgrid(lonlist,latlist);
evla = 35; evlo = -95;
distlist = distance(evla,evlo,YY(:),XX(:));
distlist=deg2km(distlist);
tt = distlist./phvel;
tgrid = griddata(XX(:),YY(:),tt,XX,YY);
tgrid2 =reshape(tgrid,size(XX))
[fx,fy]=gradient(tgrid2,deg2km(0.25),deg2km(0.25));
angle = rad2deg(atan2(fx,fy));
idx = find(angle < 0);
angle(idx) = 360+angle(idx);

subplot(2,2,1)
scatter(XX(:),YY(:),50,tgrid2(:),'filled')
hold on
scatter(evlo,evla,500,'pentagram','filled')

subplot(2,2,2)
scatter(XX(:),YY(:),50,tgrid2(:),'filled')
caxis([0 100])
hold on
quiver(XX(:),YY(:),100*fx(:),100*fy(:),'linewidth',2)
xlim([-100 -90])
ylim([30 40])
colorbar

subplot(2,2,3)
scatter(XX(:),YY(:),50,angle(:),'filled')
colorbar
colormap(hot)