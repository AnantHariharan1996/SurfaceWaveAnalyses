% Generate G Matrix Example
clear; close all; clc;
ReadKernels_Example
periods=Periodlist;
kernels=kernstore;
kernelrads=rad;
layeredges = [6000:1:6371].*1000; 
smoothinglist = [1 10^-1 10^-2 10^-3 10^-4 10^-5 10^-6 10^-7];
cmapp=jet(length(smoothinglist)+1)
[G,radcentersorig] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);

% generate dvsh perturbation

dvsh = zeros(size(radcentersorig))';
idx = find(radcentersorig >= 6294.5*1000 & radcentersorig < 6310.5*1000);

dvsh(idx) = 0.01;

% predict dc/c
dcoverc = G*dvsh;

layeredges = fliplr([6371:-1:6000]).*1000; 
dampinglist = [0];
[G,radcenters] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);


figure(1)
subplot(1,2,1)
pltlist(1).model = plot(dvsh,radcentersorig./1000,'linewidth',2,'color','k');
subplot(1,2,2)
pltlist(1).data = plot(periods,dcoverc,'linewidth',2,'color','k');

%%%% THIS IS ACCURATE. 
plotlist = [ pltlist(1).model];
plotlistdat= [ pltlist(1).data];
smoothingweight=0.00000001;
figure()
imagesc(G)
fcount=1;
for factor = smoothinglist
    fcount=fcount+1;
[Gaug,daug] = AddSmoothnessConstraint_GMatrix(G,radcenters,dcoverc,factor)
%%%%
m= inv(Gaug'*Gaug)*Gaug'*daug;


[Rads2Plot,VelocityVals2Plot] = Get_Layered_Model_For_Plotting(m,layeredges)
figure(1)
subplot(1,2,1)
hold on
pltlist(fcount).model = plot(VelocityVals2Plot,Rads2Plot./1000,'linewidth',2,'color',cmapp(fcount,:))
xlabel('dvsh/vsh')
ylabel('radius (km)')
set(gca,'fontsize',16)
legend('True Model','Best fit Model')

subplot(1,2,2)
hold on
pltlist(fcount).data=plot(periods,G*m,'linewidth',2,'linestyle','--','linewidth',2,'color',cmapp(fcount,:))
xlabel('Period (s)')
ylabel('dc/c')
set(gca,'fontsize',16)
legend('Observed','Predicted')

legarraymodel{1} = 'True Model';
legarraymodel{fcount} = ['Damping \epsilon = ' num2str(factor)];

plotlist = [plotlist pltlist(fcount).model];
plotlistdat= [plotlistdat pltlist(fcount).data];

end
subplot(1,2,1)

legend(plotlist,legarraymodel)

subplot(1,2,2)

legend(plotlistdat,legarraymodel)

set(gcf,'position',[-93 474 1477 378])