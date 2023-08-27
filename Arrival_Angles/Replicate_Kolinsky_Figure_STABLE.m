%% Replicate_Kolinsky_2020

get_kolinsky_events
% evlats = Catalog_et(idx);
% evlons = Catalog_en(idx);
% evdeps = Catalog_dep(idx);
% evmags = Catalog_MW(idx);
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
GridLon=GridLon(:);
GridLat=GridLat(:);
[ttime_field_perturbed,tau,ttime_field_noscatter,R_forgrid,x_forgrid,Q] = ...
    Get_GaussianBeam_Phase_Delay(Period,evla,evlo,...
    scatterlat,scattererlon,taumax,L,GridLat,GridLon,cglb);

[ fx,fy,angle,xgrid,ygrid,tgrid2 ] = Get_arrival_angle( evla,evlo,GridLat,GridLon,ttime_field_perturbed,spacing);% 

[ fx,fy,angle_nodiff,xgrid,ygrid,tgrid2 ] = Get_arrival_angle( evla,evlo,GridLat,GridLon,ttime_field_noscatter,spacing );% 

figure
scatter(GridLon,GridLat,25,tau,'filled')
hold on
scatter(scattererlon,scatterlat,50,'filled')
ylim([min(latlist) max(latlist)])
xlim([min(lonlist) max(lonlist)])

figure
scatter(xgrid,ygrid,25,angle,'filled')
hold on
ylim([min(latlist) max(latlist)])
xlim([min(lonlist) max(lonlist)])
colorbar

figure
scatter(xgrid,ygrid,25,angle_nodiff,'filled')
hold on
scatter(evlo,evla)
colorbar

delta = angdiff(deg2rad(angle_nodiff),deg2rad(angle))

figure
scatter(xgrid,ygrid,25,rad2deg(delta),'filled')
hold on
scatter(evlo,evla)
scatter(scattererlon,scatterlat,50,'filled')
colorbar
ylim([0 52])
 xlim([-8 32])
colormap((jet))

