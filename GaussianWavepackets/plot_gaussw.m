clear; clc; 
x=100
tlist = [0.1:0.001:1000];
vp = 4;
period = 5;
omega = 2*pi/period;
kc = omega/vp;
vg=3;
sigma=20;
kc = 50;
x_0 = 0;


x=200
[A_xt] = makegaussianwavepacket_FirstOrderDispersion(1,sigma,vg,tlist,period,x,vp);


subplot(2,1,1)
plot(tlist,A_xt)
xlim([0 300])
hold on
x=500

 [A_xt] = makegaussianwavepacket_FirstOrderDispersion(1,sigma,vg,tlist,period,x,vp);

subplot(2,1,2)
plot(tlist,A_xt)
xlim([0 300])
hold on