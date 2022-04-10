function [ h ] = Fancy_US_Plot_V2019( lon,lat,dv,cmin,cmax,minlat,maxlat,minlon,maxlon )
cmap = jet;
load coastlines
ax = axesm('mercator','Frame','On','Grid','off');
setm(gca,'MapLonLimit',[minlon maxlon])
setm(gca,'MapLatLimit',[minlat maxlat])

scatterm(lat,lon,30,dv,'filled')

states = shaperead('usastatelo', 'UseGeoCoords', true,...
  'Selector',...
  {@(name) ~any(strcmp(name,{'Alaska','Hawaii'})), 'Name'});
hold on
geoshow(gca, states, 'DisplayType', 'polygon','FaceColor', [1 1 1],'facealpha',.01)

colormap(cmap)
caxis([cmin cmax])
% xlabel('\textbf{Longitude}','interpreter','latex','fontsize',14)
% ylabel('\textbf{Latitude}','interpreter','latex','fontsize',14)
h = colorbar
setm(gca,'fontsize',14)
setm(gca,'frame','on')
setm(gca,'parallellabel','on')
setm(gca,'meridianlabel','off')
setm(gca,'LabelFormat','none')
setm(gca,'FFaceColor',[0.9 0.9 0.9])

tightmap
axis tight
end

