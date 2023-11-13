clear;
close all
Vs = [0.1:0.001:5.25];
[Vp,Rho] = Predict_VpRho_Brochers(Vs);
Vplist= [1.5:0.001:9];
%Y = diff(f)/h; 
Vsreglist = interp1(Vp,Vs,Vplist)
subplot(1,2,1)
plot(Vs,Vp,'linewidth',2,'color','k');
hold on
plot(Vs,Vp,'linewidth',1,'linestyle','--');
% now I have Vs on a regular grid of Vp values, and can evaluate the
% derivative. 
dVsoverdVp = diff(Vsreglist)/(Vplist(2)-Vplist(1));
subplot(1,2,2)
plot(Vsreglist(1:end-1),dVsoverdVp)
zz(:,1) = Vsreglist(1:end-1);
zz(:,2) = dVsoverdVp;
save(['Vs_dVsoverdVp_BrochersPrediction.mat'],'zz','-mat')
