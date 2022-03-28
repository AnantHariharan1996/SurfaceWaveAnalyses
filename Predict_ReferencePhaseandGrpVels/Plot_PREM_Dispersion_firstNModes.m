%% Plot_PREM_Phase_and_Group_Velocities
clear; clc; %close all;
maxn=1;

cmapp = hsv((maxn+1));



%%%%% Do not touch anything below here

[nval lval period cv gv q]=read_dotqfile('PREM750_LoveWaves_QFile_Output');
figure()
cpltlist = []; gpltlist = [];
for n = [0:1:maxn]
    legendlist{n+1} = ['n = ' num2str(n)];
idx = find(nval == n);


subplot(1,2,1)
pltstr.cplt(n+1) = plot(period(idx),cv(idx),'linewidth',2,'color',cmapp(n+1,:));
hold on
xlim([20 200])
ylim([3 7])
xlabel('Period (s)')
ylabel('Phase Velocity (km/s)')
set(gca,'fontsize',16,'fontweight','bold')
grid on; box on;

subplot(1,2,2)
pltstr.gplt(n+1) = plot(period(idx),gv(idx),'linewidth',2,'color',cmapp(n+1,:));
hold on
xlim([20 200])
ylim([3 7])
xlabel('Period (s)')
ylabel('Group Velocity (km/s)')
set(gca,'fontsize',16,'fontweight','bold')
grid on; box on;



cpltlist = [cpltlist pltstr.cplt(n+1)];
gpltlist = [gpltlist pltstr.gplt(n+1)];

end


% legends
subplot(1,2,1)
hlegend=legend(cpltlist,legendlist,'location','eastoutside')

subplot(1,2,2)
hlegend=legend(gpltlist,legendlist,'location','eastoutside')

set(gcf,'position',[167 426 1346 412])