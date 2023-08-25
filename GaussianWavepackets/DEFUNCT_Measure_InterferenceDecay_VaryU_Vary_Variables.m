clear; clc; close all
x=100
tlist = [-1000:1:100000];
vp = 4;
period = 50;
omega = 2*pi/period;
kc = omega/vp;
vg=4.42;
vg1=4.61;
vp=4.72;
vp1=10;

degs=[1:0.1:200]
xlist = deg2km(degs);

%%%%%5
vg1list = [4.1 4.2 4.3 4.4 4.5 4.6];
vglist = [4*ones(size(vg1list))];
vplist = [4.72*ones(size(vg1list))];
vp1list = [1030.31*ones(size(vg1list))];
periodlist = [50*ones(size(vg1list))];

for ijk = 1:length(periodlist)
period = periodlist(ijk);
vg1=vg1list(ijk);
vg = vglist(ijk);
vp = vplist(ijk);
vp1 = vp1list(ijk);

sigma=period*1;
kc = 50;
x_0 = 0;
xcounter=0;


pred_grptime_n1 = xlist./vg1;
pred_grptime_n0 = xlist./vg;

for x = xlist
    xcounter=xcounter+1;
    [A_xt] = makegaussianwavepacket_FirstOrderDispersion(1,sigma,vg,tlist,period,x,vp);
        [A_xt_2] = makegaussianwavepacket_FirstOrderDispersion(0.49,sigma,vg1,tlist,period,x,vp1);
% [GrpTime(xcounter)] = NOFILT_Get_Group_Arrival_Time(tlist,real(A_xt+A_xt_2));
% [GrpTime_n0(xcounter)] = NOFILT_Get_Group_Arrival_Time(tlist,real(A_xt));

[GrpTime(xcounter)] = Get_Group_Arrival_Time(tlist,real(A_xt+A_xt_2),125*1.1,125*0.9);
[GrpTime_n0(xcounter)] = Get_Group_Arrival_Time(tlist,real(A_xt),125*1.1,125*0.9);

end


figure(1)
subplot(length(vg1list),1,ijk)
plot(degs,GrpTime-GrpTime_n0,'-o','linewidth',2)
hold on

[maxval,maxdx] = max(GrpTime-GrpTime_n0);
maxdist(ijk)= deg2km(degs(maxdx));
grptimediff_pred(ijk) = maxdist(ijk)/vg-maxdist(ijk)/vg1;

ylim([-100 100])
xlim([1 360])
ylabel('FM+N1 T_g - FM T_g (s)')
set(gca,'fontweight','bold','fontsize',14)
grid on; box on;
title(['U_0 = ' num2str(vg) ', U_1 = ' num2str(vg1) 'km/s'])



end
xlabel('Epicentral Distance (deg)')
sgtitle('Varying Group Velocity Difference','fontweight','bold')
set(gcf,'position',[37 54 319 809])
%saveas(gcf,'VaryingU.eps','epsc')
figure()
plot(vg1list-vglist,maxdist)

figure()
plot(vg1list-vglist,grptimediff_pred)