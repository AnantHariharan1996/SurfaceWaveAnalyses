function [delta,xgrid,ygrid,ttime_field_perturbed,tau,ttime_field_noscatter] ...
    = Get_Arrival_Angle_Residual_GaussianBeam(Period,evla,evlo,...
    scatterlat,scattererlon,taumax,L,GridLat,GridLon,cglb,spacing)

% 1) Get phase delay with and without the scatterer
[ttime_field_perturbed,tau,ttime_field_noscatter,R_forgrid,x_forgrid,Q] = ...
    Get_GaussianBeam_Phase_Delay(Period,evla,evlo,...
    scatterlat,scattererlon,taumax,L,GridLat,GridLon,cglb);
disp('Calculated Phase traveltime fields')

% 2) Get arrival angles with and without the scatterer
[ fx,fy,angle,xgrid,ygrid,tgrid2 ] = Get_arrival_angle( evla,evlo,...
    GridLat,GridLon,ttime_field_perturbed,spacing);% 

[ fx,fy,angle_nodiff,xgrid,ygrid,tgrid2 ] = Get_arrival_angle( evla,evlo,...
    GridLat,GridLon,ttime_field_noscatter,spacing );%
disp('Calculated Arrival Angles')

% 3) get difference between angles
delta = angdiff(deg2rad(angle_nodiff),deg2rad(angle));
delta=rad2deg(delta);
disp('Differenced Arrival Angles')


end