%% Example of a wrapper to the GDM52 fortran of codes
%% Compare the GDM52 phase velocity maps to the Babikoff and Dalton Rayleigh wave phase
%% velocities. 
clear; clc; close all
c_dir = ['/Users/ananthariharan/Documents/GitHub/SurfaceWaveAnalyses/Get_dcoverc_USArray/'];
axmat(1,:) = [4.1 4.4]
axmat(2,:) = [4.3 4.6]

periodlist2use = [140 180];
pcounter=0;
for period = periodlist2use
pcounter=pcounter+1;
cfname = [c_dir 'c_' num2str(period) 's_BD19']
cnfo = load(cfname,'-ASCII')
lons = cnfo(:,2); lats = cnfo(:,1);
subplot(2,2,pcounter)
scatter(lons,lats,10,cnfo(:,3)./1000,'filled')
title(['Babikoff & Dalton; Period ' num2str(period) 's'])
set(gca,'fontsize',20,'fontweight','bold')

colorbar;
caxis(axmat(pcounter,:))
xlim([-121.5000 -69.2838])
ylim([30 47.6261])

end

%% NOW GET THE CORRESPPONDING GDM52 MEASUREMENTS

for ijk = 1:length(lons)
    100*ijk/length(lons)
currlon= lons(ijk); currlat= lats(ijk);

% generate the file for the GDM52 codes
fid = fopen('RunGDM52.sh','w');
fprintf(fid,'#!/bin/csh');
fprintf(fid,'\n');
fprintf(fid,'/Users/ananthariharan/Documents/GitHub/GroupVelocity_OvertoneInterference/RealData/GDM52_dispersion <<!')
fprintf(fid,'\n');
fprintf(fid,'77');
fprintf(fid,'\n');
fprintf(fid,'2');
fprintf(fid,'\n');
fprintf(fid,[num2str(currlat) ' ' num2str(currlon) '']);
fprintf(fid,'\n');
fprintf(fid,'99');
fprintf(fid,'\n');
fprintf(fid,'!');
fclose(fid)
system('chmod 777 RunGDM52.sh');
system('./RunGDM52.sh');
data = read_dispersion_data('GDM52_dispersion.out');

periodlist = 1000./(data(:,1));
Clist = data(:,3);
% get grp vel at the exact period we are analyzing
current_C = interp1(periodlist,Clist,periodlist2use); 
cstore(ijk,:) = current_C;

end

pcounter=0;

for period = periodlist2use
pcounter=pcounter+1

subplot(2,2,pcounter+2)
scatter(lons,lats,10,cstore(:,pcounter),'filled')
title(['GDM52 (Ekström, 2011); Period ' num2str(period) 's'])
set(gca,'fontsize',20,'fontweight','bold')
barbar=colorbar;
caxis(axmat(pcounter,:))
ylabel(barbar,'Phase Velocity (km/s)')
xlim([-121.5000 -69.2838])
ylim([30 47.6261])
end

colormap(flipud(turbo))



set(gcf,'position',[25 193 1392 598])



%%%%% MAKE HISTOGRAM OF ERRORS
pcounter=0;
for period = periodlist2use
pcounter=pcounter+1;
cfname = [c_dir 'c_' num2str(period) 's_BD19']
cnfo = load(cfname,'-ASCII')
lons = cnfo(:,2); lats = cnfo(:,1);
c = cnfo(:,3)./1000;

figure(20)
subplot(2,1,pcounter)
histogram(c-cstore(:,pcounter))
xlabel('c_{BabikoffDalton} - c_{GDM52} (km/s)')
set(gca,'fontsize',18,'fontweight','bold')
ylabel('N)')
title(['Comparison at ' num2str(period) 's'])
end