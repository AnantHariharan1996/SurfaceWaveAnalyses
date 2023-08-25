clear; clc; close all
x=100
tlist = [-1000:0.5:10000];
vp = 4;
period = 50;
omega = 2*pi/period;
kc = omega/vp;
vg=4.42;
vg1=4.61;
vp=4.72;
vp1=10;

degs=[5:0.5:150]
xlist = deg2km(degs);

%%%%%5
vg1list = [4.8];
vglist = [4*ones(size(vg1list))];
vplist = [4.72*ones(size(vg1list))];
vp1list = [50.31*ones(size(vg1list))];
periodlist = [100*ones(size(vg1list))];

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

[GrpTime_n0(xcounter),YUPPER] = Get_Group_Arrival_Time(tlist,real(A_xt),125*1.1,125*0.9);
[GrpTime(xcounter),YUPPER] = Get_Group_Arrival_Time(tlist,real(A_xt+A_xt_2),125*1.1,125*0.9);

  figure(2)
  subplot(1,2,1)
  if rem(degs(xcounter),5) == 0
        plot(tlist-GrpTime_n0(xcounter),50*YUPPER+degs(xcounter),'linewidth',2,'color','b')
        hold on
  end
      %   plot(tlist-GrpTime_n0(xcounter),real(A_xt_2+A_xt)+degs(xcounter),'linewidth',1,'color','k')
        %  plot(tlist-GrpTime_n0(xcounter),real(A_xt)+degs(xcounter),'linewidth',1,'color','r')
      
hold on
ylim([5 150])
xlim([-2500 2500])
ylabel('Envelope Plotted at Epicentral Distance (deg)')
xlabel('Time (s)')
set(gca,'fontweight','bold','fontsize',14)

end



figure(2)
subplot(1,2,2)
plot(GrpTime-GrpTime_n0,degs,'-o','linewidth',2)
hold on
xlim([-100 100])
ylim([5 150])
xlabel('FM+N1 T_g - FM T_g (s)')
set(gca,'fontweight','bold','fontsize',14)
grid on; box on;
title(['U_0 = ' num2str(vg) ', U_1 = ' num2str(vg1) 'km/s'])



end
sgtitle('Origin of the Decrease in Group Velocity Overtone Interference','fontweight','bold')
set(gcf,'position',[37 54 319 809])
saveas(gcf,['Schematic_DistDep.eps'],'epsc')
