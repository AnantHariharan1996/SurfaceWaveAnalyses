clear; clc; close all
x=100
tlist = [1:0.5:10000];
vp = 4;
period = 125;
omega = 2*pi/period;
kc = omega/vp;
vg=4.42;
vg1=4.61;
vp=4.72;
vp1=6.31;
%vp1 = 4.4

sigma=period*1;
kc = 50;
x_0 = 0;
xcounter=0;
degs=[30:1:150]
xlist = deg2km(degs);

pred_grptime_n1 = xlist./vg1;
pred_grptime_n0 = xlist./vg;


x = xlist(1);
    xcounter=xcounter+1;
    [A_xt] = makegaussianwavepacket_FirstOrderDispersion(1,sigma,vg,tlist,period,x,vp);
        [A_xt_2] = makegaussianwavepacket_FirstOrderDispersion(0.49,sigma,vg1,tlist,period,x,vp1);
figure(1)
subplot(2,1,2)
    plot(tlist,real(A_xt),'linewidth',4,'color','k')
hold on
    plot(tlist,real(A_xt_2),'linewidth',4,'color','r')
xlim([0 2000])
        [A_xt] = makegaussianwavepacket_FirstOrderDispersion(1,sigma,vg-2,tlist,period,x,vp);
        [A_xt_2] = makegaussianwavepacket_FirstOrderDispersion(0.49,sigma,vg1,tlist,period,x,vp1);
ylabel('Displacement (m)')
ylabel('Displacement (m)')
title('Undesired')
legend('Overtone','Fundamental Mode')
set(gca,'fontsize',14,'fontweight','bold')
set(gca,'fontsize',16)
grid on; box on;
xlabel('Time (s)')
set(gca,'fontsize',20)
    subplot(2,1,1)
    plot(tlist,real(A_xt),'linewidth',4,'color','k')
hold on
    plot(tlist,real(A_xt_2),'linewidth',4,'color','r')

    xlim([0 2000])
ylabel('Displacement (m)')
set(gca,'fontsize',14,'fontweight','bold')
title('Desired')
grid on; box on;
legend('Overtone','Fundamental Mode')
set(gca,'fontsize',20)