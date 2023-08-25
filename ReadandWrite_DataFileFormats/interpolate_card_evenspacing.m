clear; clc; close all;

cardfile='STW105_CARDS';
[ model,discz ] = read_cardfile( cardfile )

discretization_km=1;
discretization_m = 1000*discretization_km;
discretization_km_limit = 300;
array_to_define = [0:discretization_km:discretization_km_limit];
rhostore = [];
vpvstore = [];
vsvstore = [];
vphstore = [];
vshstore = [];
qkstore=[];
qmstore=[];
etastore=[];
zstore = [];

for ijk = 1:length(model.Z)-1
currz = model.Z(ijk);
nextz = model.Z(ijk+1);
known_zs = [currz nextz];
% in km
% check if the space in between the points is greater than the discretization
zdiff = nextz-currz;
if zdiff > discretization_km
% get the points we want to interpolate
idx2get = find(array_to_define >currz & array_to_define< nextz)
points2interpon = array_to_define(idx2get);
%do interpolation now
% for rho
curr_rho = model.rho(ijk);
next_rho = model.rho(ijk+1);
rhoq = interp1(known_zs,[curr_rho next_rho],points2interpon);
%for vpv
curr_vpv = model.Vpv(ijk);
next_vpv = model.Vpv(ijk+1);
vpvq = interp1(known_zs,[curr_vpv next_vpv],points2interpon);

%for vsv
curr_vsv = model.Vsv(ijk);
next_vsv = model.Vsv(ijk+1);
vsvq = interp1(known_zs,[curr_vsv next_vsv],points2interpon);

% for vph
curr_vph = model.Vph(ijk);
next_vph = model.Vph(ijk+1);
vphq = interp1(known_zs,[curr_vph next_vph],points2interpon);

% for Vsh
curr_vsh = model.Vsh(ijk);
next_vsh = model.Vsh(ijk+1);
vshq = interp1(known_zs,[curr_vsh next_vsh],points2interpon);

%for Qk
curr_qk = model.Qk(ijk);
next_qk = model.Qk(ijk+1);
Qkq = interp1(known_zs,[curr_qk next_qk],points2interpon);

% for Qm
curr_qm = model.Qm(ijk);
next_qm = model.Qm(ijk+1);
Qmq = interp1(known_zs,[curr_qm next_qm],points2interpon);

% for etaa
curr_eta = model.eta(ijk);
next_eta = model.eta(ijk+1);
etaq = interp1(known_zs,[curr_eta next_eta],points2interpon);

%etaq = (vshq./vsvq).^2;
% for Vs
% for Vp
 % store measurements in card file    
rhostore = [rhostore model.rho(ijk) rhoq];
vpvstore = [vpvstore model.Vpv(ijk) vpvq];
vsvstore = [vsvstore model.Vsv(ijk) vsvq];
vphstore = [vphstore model.Vph(ijk) vphq];
vshstore = [vshstore model.Vsh(ijk) vshq];
qkstore=[qkstore model.Qk(ijk) Qkq];
qmstore=[qmstore model.Qm(ijk) Qmq];
etastore=[etastore model.eta(ijk) etaq];
zstore = [zstore model.Z(ijk) points2interpon];


else
 % store measurements in card file    
rhostore = [rhostore model.rho(ijk)];
vpvstore = [vpvstore model.Vpv(ijk)];
vsvstore = [vsvstore model.Vsv(ijk)];
vphstore = [vphstore model.Vph(ijk)];
vshstore = [vshstore model.Vsh(ijk)];
qkstore=[qkstore model.Qk(ijk)];
qmstore=[qmstore model.Qm(ijk)];
etastore=[etastore model.eta(ijk)];
zstore = [zstore model.Z(ijk)];


end


end

 % store measurements in card file    
rhostore = [rhostore model.rho(ijk+1)];
vpvstore = [vpvstore model.Vpv(ijk+1)];
vsvstore = [vsvstore model.Vsv(ijk+1)];
vphstore = [vphstore model.Vph(ijk+1)];
vshstore = [vshstore model.Vsh(ijk+1)];
qkstore=[qkstore model.Qk(ijk+1)];
qmstore=[qmstore model.Qm(ijk+1)];
etastore=[etastore model.eta(ijk+1)];
zstore = [zstore model.Z(ijk+1)];


%%%% 
%%%% MAKE VERIFICATION PLOT
%%%%



figure(999)
subplot(3,3,1)
plot(model.Vsv,model.Z,'-ko','linewidth',2)
ylim([0 350])
set(gca,'ydir','reverse')
hold on
hold on
plot(vsvstore,zstore,'-ro','linewidth',5)
plot(model.Vsv,model.Z,'-ko','linewidth',2)
%ylim([0 100])
xlabel('Vsv')

subplot(3,3,2)
plot(model.Vsh,model.Z,'-ko','linewidth',2)
ylim([0 350])
set(gca,'ydir','reverse')
hold on
hold on
plot(vshstore,zstore,'-ro','linewidth',5)
plot(model.Vsh,model.Z,'-ko','linewidth',2)
%ylim([0 100])
xlabel('Vsh')


subplot(3,3,3)
plot(model.rho,model.Z,'-ko','linewidth',2)
ylim([0 350])
set(gca,'ydir','reverse')
hold on
hold on
plot(rhostore,zstore,'-ro','linewidth',5)
plot(model.rho,model.Z,'-ko','linewidth',2)
%ylim([0 100])
xlabel('\rho')



subplot(3,3,4)
plot(model.Vpv,model.Z,'-ko','linewidth',2)
ylim([0 350])
set(gca,'ydir','reverse')
hold on
hold on
plot(vpvstore,zstore,'-ro','linewidth',5)
plot(model.Vpv,model.Z,'-ko','linewidth',2)
%ylim([0 100])
xlabel('Vpv')



subplot(3,3,5)
plot(model.Vph,model.Z,'-ko','linewidth',2)
ylim([0 350])
set(gca,'ydir','reverse')
hold on
hold on
plot(vphstore,zstore,'-ro','linewidth',5)
plot(model.Vph,model.Z,'-ko','linewidth',2)
%ylim([0 100])
xlabel('Vph')


subplot(3,3,6)
plot(model.eta,model.Z,'-ko','linewidth',2)
ylim([0 350])
set(gca,'ydir','reverse')
hold on
hold on
plot(etastore,zstore,'-ro','linewidth',5)
plot(model.eta,model.Z,'-ko','linewidth',2)
%ylim([0 100])
xlabel('\eta')