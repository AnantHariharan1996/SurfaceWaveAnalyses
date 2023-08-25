%% D_VisualizeEnsembleResults
%
% Load the MCMC results, plot tradeoffs and ensemble
clear; clc; close all
Chain=4575;
Model_Depths = [0:5:80];

load(['Stored_Likelihood_Chain' num2str(Chain) '.mat'])
load(['Stored_Model_Chain' num2str(Chain) '.mat'])

%%%%%%%%%%
figure(1)
plot([1:length(Stored_Likelihood)],Stored_Likelihood,'-o','linewidth',2)
ylabel('Likelihood')
xlabel('Accepted Model #')
set(gca,'fontsize',16)
set(gcf,'position',[15 390 1354 470])
burnin=input('Burn In Model Number?')
hold on
plot([burnin burnin],[0 1],'linewidth',2,'linestyle','--')
legend('Chain Evolution','Burn-In')

%%%%%%%%%% Plot ensemble after burnin
figure(100)
cmappp= winter(length(Stored_Model(:,1)));
for ijk= 1:length(Stored_Model(:,1))

plot(Stored_Model(ijk,:),Model_Depths,'linewidth',2,'color',cmappp(ijk,:))
hold on

set(gca,'ydir','reverse','fontsize',16)
xlabel('Vsh(m/s)')
ylabel('Depth(km)')
xlim([0 5000])

end

colormap(cmappp)
colorbar
caxis([1 length(Stored_Model(:,1))])
barbar=colorbar;
ylabel(barbar,'Model # in Ensemble')
