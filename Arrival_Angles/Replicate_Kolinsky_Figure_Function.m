%% Replicate_Kolinsky_2020

get_kolinsky_events

cglb = 4;
Period = 50; %km/s
evla=evlats(1);
evlo=evlons(1);
scatterlat = 10.5;
scattererlon = 15;
taumax = 23.61;
lambda = Period*cglb;
Loverlambda = 0.95;
spacing=0.2;
L = Loverlambda*lambda;
lonlist = [-8:spacing:35];
latlist = [-4:spacing:52];
[GridLon,GridLat] = meshgrid(lonlist,latlist);
GridLon=GridLon(:); GridLat=GridLat(:);

[delta,xgrid,ygrid,ttime_field_perturbed,tau,ttime_field_noscatter] ...
    = Get_Arrival_Angle_Residual_GaussianBeam(Period,evla,evlo,...
    scatterlat,scattererlon,taumax,L,GridLat,GridLon,cglb,spacing);


%%%% PLOTTING BELOW HERE
%%%%

figure
scatter(xgrid,ygrid,25,(delta),'filled')
hold on
scatter(evlo,evla)
scatter(scattererlon,scatterlat,50,'filled')
colorbar
ylim([0 52])
xlim([-8 32])
colormap((jet))
caxis([-20 20])

zz(:,1)=xgrid;
zz(:,2)=ygrid;
zz(:,3)=delta;

dlmwrite('Kolinsky_xyz',zz,'delimiter','\t','precision','%.9f')
