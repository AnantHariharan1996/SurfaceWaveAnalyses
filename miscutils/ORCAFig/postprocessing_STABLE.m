close all;clc; clear all
addpath(genpath(pwd))
xnum=101;
ynum=101;
tbottom=3000;
ttop=273;
[xgrd,ygrd] = meshgrid([1:1:xnum],[1:1:ynum]);



figure(1)
ax1 = subplot(2,2,1)
load('downwellinglith.mat')
%imagesc(tmptmp)
contourf(xgrd,ygrd,-1.*tmptmp,-1*[500 1600],'linewidth',2,'linecolor','k')
% colormap([0.4470588235294118 0.054901960784313725 0.027450980392156862; ...
%     0.9333333333333333 0.8117647058823529 0.42745098039215684])
% % clabel(c,h)

colormap(ax1,flipud([0.13725490196078433 0.39215686274509803 0.6666666666666666; ...
     0.9333333333333333 0.8117647058823529 0.42745098039215684]))
% % clabel(c,h)
%contourfcmap(xgrd,ygrd,tmptmp,[500 1600],[0 0 1])
set(gca,'ydir','reverse')
ylim([1 30])

set(gca,'ydir','reverse','linewidth',3)
xticks([])
yticks([])
% ylabel('No Melt','FontName','Arial','fontweight','bold','fontsize',32)
title({'Top-Down Convection',' '},'FontName','Arial','fontweight','bold','fontsize',32)
text(78,3,'1100 K','FontName','Arial','fontweight','bold','fontsize',22,'color','k')
text(65,6,'1350 K','FontName','Arial','fontweight','bold','fontsize',22,'color','k')

xlabel('+\delta V = Cold; -\delta V = Ambient','fontsize',32,'fontweight','bold')
ax2 = subplot(2,2,2)

load('threerisingblob.mat')
tmpxgrd = xgrd(:);
tmpygrd = ygrd(:);
newtmptmp = tmptmp;
for ijk = 1:length(xgrd(:))
    pt2smoothx = tmpxgrd(ijk);
pt2smoothy =tmpygrd(ijk);
dist2grid = distance(pt2smoothy,pt2smoothx,tmpygrd,tmpxgrd);

idx = find(dist2grid < 1);
newtmptmp(idx) = median(tmptmp(idx));

end

tmptmp = imgaussfilt(tmptmp,0.7);

tmptmp(find(tmptmp  > 1650)) = 2000;
newtmptmp(find(tmptmp  > 1650)) = 2000;

contourf(xgrd,ygrd,-1.*tmptmp,-1.*[1660 2000],'linewidth',2,'linecolor','k')
%clabel(c,h)
set(gca,'ydir','reverse')
ylim([0 30])

colormap(ax2,([0.4470588235294118 0.054901960784313725 0.027450980392156862; ...
     0.9333333333333333 0.8117647058823529 0.42745098039215684]))
%xlim([20 110])

set(gca,'ydir','reverse','linewidth',3)
xticks([])
yticks([])

% title('Bottom-Up Convection','FontName','Arial','fontweight','bold','fontsize',32)
title({'Bottom-Up Convection',' '},'FontName','Arial','fontweight','bold','fontsize',32)

xlabel('+\delta V = Ambient; -\delta V = Hot (Melt)','fontsize',32,'fontweight','bold')
text(60,6,'1350 K','FontName','Arial','fontweight','bold','fontsize',24,'color','k')
text(60-18,8,'1440 K','FontName','Arial','fontweight','bold','fontsize',24,'color','white')

x1 = 10.2;  x2 = x1+(19-6)
y1 = 6; y2 = 6;
e = 0.9975;

 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
patch(x,y,[1 0 1],'edgecolor','k','linewidth',2)

x1 = 43.2;  x2 = x1+(19-6)
%e = 0.995;

 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
patch(x,y,[1 0 1],'edgecolor','k','linewidth',2)

x1 = 78;  x2 = x1+(19-6)
%e = 0.995;

 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
patch(x,y,[1 0 1],'edgecolor','k','linewidth',2)


patch([min(xgrd(:)) max(xgrd(:)) max(xgrd(:)) min(xgrd(:)) min(xgrd(:))],[3 3 0 0 3],[0.13725490196078433 0.39215686274509803 0.6666666666666666],'edgecolor','k','linewidth',2)



text(78,1.5,'1100 K','FontName','Arial','fontweight','bold','fontsize',22,'color','k')


ax3= subplot(2,2,3)
load('downwellinglith.mat')
%imagesc(tmptmp)
contourf(xgrd,ygrd,-1.*tmptmp,-1*[500 1600],'linewidth',2,'linecolor','k')
% colormap([0.4470588235294118 0.054901960784313725 0.027450980392156862; ...
%     0.9333333333333333 0.8117647058823529 0.42745098039215684])
% % clabel(c,h)

colormap(ax3,flipud([0.40784313725490196 0.5450980392156862 0.7490196078431373; ...
     0.9333333333333333 0.8117647058823529 0.42745098039215684]))
% % clabel(c,h)
%contourfcmap(xgrd,ygrd,tmptmp,[500 1600],[0 0 1])
set(gca,'ydir','reverse')
ylim([1 30])
% ylabel('Melt','FontName','Arial','fontweight','bold','fontsize',32)


text(78,3,'1260 K','FontName','Arial','fontweight','bold','fontsize',24,'color','k')
text(65,6,'1350 K','FontName','Arial','fontweight','bold','fontsize',24,'color','k')



x1 = 26;  x2 = x1+(19-6)
y1 = 8; y2 = 8;
e = 0.9975;

 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
patch(x,y,[1 0 1],'edgecolor','k','linewidth',2)

x1 = 59;  x2 = x1+(19-6)
y1 = 8; y2 = 8;
%e = 0.995;

 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
patch(x,y,[1 0 1],'edgecolor','k','linewidth',2)


set(gca,'ydir','reverse','linewidth',3)
xticks([])
yticks([])
xlabel('+\delta V = Cold; -\delta V = Ambient (Melt)','fontsize',32,'fontweight','bold')

hold on
% quiver(60,25,5/1.2,-7/1,2,'linewidth',3,'MaxHeadSize',100,'color','red')
% quiver(80,25,-5/1.2,-7/1,2,'linewidth',3,'MaxHeadSize',100,'color','red')


ax4= subplot(2,2,4)
load('downwellinglith.mat')
pt2smoothx = 24.6;
pt2smoothy = 6.1;
dist2grid = distance(pt2smoothy,pt2smoothx,ygrd,xgrd);
idx = find(dist2grid < 2);
tmptmp(idx) = median(tmptmp(idx));
% tmptmp = imgaussfilt(tmptmp,1)
% scatter(pt2smoothx,pt2smoothy,150)
% hold on
tmp2 =  load('threerisingblob.mat')
layer2 = tmp2.tmptmp;
layer2 = imgaussfilt(layer2,1)

layer2(find(tmptmp  > 1650)) = 2000;

layer2(:,17:101) = layer2(:,1:85)
layer2(:,1:22) = 1600

%imagesc(tmptmp)
contourf(xgrd,ygrd,-1.*(imgaussfilt(tmptmp,0.5)+layer2),-1*(1600+[520 1600 3200]),'linewidth',2,'linecolor','k')
%colorbar %-1*(1600+[500 1600 2000]),'linewidth',2,'linecolor','k')
% colormap([0.4470588235294118 0.054901960784313725 0.027450980392156862; ...
%     0.9333333333333333 0.8117647058823529 0.42745098039215684])
% % clabel(c,h)

colormap(ax4,flipud([0.6784313725490196 0.6980392156862745 0.8274509803921568; ...
    0.9333333333333333 0.8117647058823529 0.42745098039215684; ...
    0.5647058823529412 0.3764705882352941 0.42745098039215684]))
% % clabel(c,h)
%contourfcmap(xgrd,ygrd,tmptmp,[500 1600],[0 0 1])
set(gca,'ydir','reverse')
ylim([1 30])
% 
 load('threerisingblob.mat')
 hold on
 %[c,h]=contour(xgrd,ygrd,tmptmp,[1600 1600])
% scatter(pt2smoothx,pt2smoothy,20,'filled')
% contourf(xgrd,ygrd,-1.*tmptmp,-1*[1600 1600],'linewidth',2,'linecolor','k')
% 
% 
% 
x1 = 26.5;  x2 = x1+(19-6)
y1 = 8; y2 = 8;
%e = 0.995;

 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
patch(x,y,[1 0 1],'edgecolor','k','linewidth',2)

x1 = 60;  x2 = x1+(19-6)
y1 = 8; y2 = 8;
%e = 0.995;

 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
patch(x,y,[1 0 1],'edgecolor','k','linewidth',2)

xlabel('+\delta V = Cold; -\delta V = Hot (Melt)','fontsize',32,'fontweight','bold','Color','k')

text(78,3,'1310 K','FontName','Arial','fontweight','bold','fontsize',22,'color','k')
text(60,10,'1400 K','FontName','Arial','fontweight','bold','fontsize',22,'color','k')


set(gca,'ydir','reverse','linewidth',3)
xticks([])
yticks([])
ylim([1 30])
set(gcf,'position',[-188 92 1701 774])
% text(-32,-5,'\Delta V = Constant','fontsize',32,'fontweight','bold')
saveas(gcf,'Schematic_Figure.png')