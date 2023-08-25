clear; clc; close all
x=100
tlist = [-1000:0.5:10000];
vp = 4;
period = 125;
omega = 2*pi/period;
kc = omega/vp;
vg=4.42;
vg1=4.61;
vp=4.72;
vp1=6.31;

degs=[5:1:150]
xlist = deg2km(degs);

%%%%%5
vg1list = [4.2 4.2 4.2 4.2];
vglist = [4*ones(size(vg1list))];
vplist = [4.72*ones(size(vg1list))];
vp1list = [4.8 5.8 6.8 7.8];
periodlist = [125 125 125 125];

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
plot(degs,GrpTime-GrpTime_n0,'-o','linewidth',2,'color','k')
hold on
ylim([-100 100])
xlim([5 150])
ylabel('FM+N1 T_g - FM T_g (s)')
set(gca,'fontweight','bold','fontsize',14)
grid on; box on;
title(['c_0 = ' num2str(vp) ' km/s, ' 'c_1 = ' num2str(vp1) ' km/s'])



end
xlabel('Epicentral Distance (deg)')
sgtitle('Varying Phase Velocity','fontweight','bold')
set(gcf,'position',[37 54 319 809])

saveas(gcf,'VaryingC.eps','epsc')