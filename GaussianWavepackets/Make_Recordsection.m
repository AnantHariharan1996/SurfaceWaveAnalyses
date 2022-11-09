clear; clc; close all
x=100
tlist = [1:1:10000];
vp = 4;
period = 50;
omega = 2*pi/period;
kc = omega/vp;
vg=4.4;
vg1=4.5;
vp=4.4;
vp1=6;
%vp1 = 4.4

sigma=period;
kc = 50;
x_0 = 0;
xcounter=0;
degs=[30:1:300]
xlist = deg2km(degs);

pred_grptime_n1 = xlist./vg1;
pred_grptime_n0 = xlist./vg;


for x = xlist
    xcounter=xcounter+1;
    [A_xt] = makegaussianwavepacket_FirstOrderDispersion(2,sigma,vg,tlist,period,x,vp);
        [A_xt_2] = makegaussianwavepacket_FirstOrderDispersion(1,sigma,vg1,tlist,period,x,vp1);
figure(1)
    plot(tlist,real(A_xt)+degs(xcounter),'linewidth',2,'color','k')
hold on
    plot(tlist,real(A_xt_2)+degs(xcounter),'linewidth',2,'color','r')
    hold on
    figure(2)

        plot(tlist,real(A_xt_2+A_xt)+degs(xcounter),'linewidth',2,'color','b')
hold on
[GrpTime(xcounter)] = NOFILT_Get_Group_Arrival_Time(tlist,real(A_xt+A_xt_2));
[GrpTime_n0(xcounter)] = NOFILT_Get_Group_Arrival_Time(tlist,real(A_xt));

end
ylim([0 140])
figure(3)
subplot(2,1,1)
plot(degs,GrpTime-GrpTime_n0,'-ko','linewidth',2)
ylim([-40 40])
subplot(2,1,2)
plot(degs,pred_grptime_n0-pred_grptime_n1)
hold on
plot(degs,ones(size(pred_grptime_n0)).*period)

