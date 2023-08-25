% Generate G Matrix Example
clear; close all; clc;
ReadKernels_Example
periods=Periodlist;
kernels=kernstore;
kernelrads=rad;
layeredges = [6000:1:6371].*1000;

[G,radcenters] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);

% generate dvsh perturbation

dvsh = zeros(size(radcenters))';
idx = find(radcenters >= 6294.5*1000 & radcenters < 6310.5*1000);

dvsh(idx) = 0.01;

% predict dc/c
dcoverc = G*dvsh;

figure(1)
subplot(1,2,1)
plot(dvsh*100,radcenters./1000,'linewidth',2)
subplot(1,2,2)
plot(periods,dcoverc*100,'linewidth',2,'color','k')

%%%% THIS IS ACCURATE. 

figure()
imagesc(G)

%%%%
m= inv(G'*G+0.0001*eye(size(G'*G)))*G'*dcoverc
figure(1)
subplot(1,2,1)
hold on
plot(m*100,radcenters./1000,'linewidth',2)
xlabel('dvsh/vsh (%)')
ylabel('radius (km)')
set(gca,'fontsize',16)
legend('True Model','Best fit Model')

subplot(1,2,2)
hold on
plot(periods,G*m*100,'linewidth',2,'color','r','linestyle','--','linewidth',2)
xlabel('Period (s)')
ylabel('dc/c (%)')
set(gca,'fontsize',16)
legend('Observed','Predicted')
