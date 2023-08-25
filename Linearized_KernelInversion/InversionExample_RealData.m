% Generate G Matrix 


clear; close all; clc;
ReadKernels_Example
periods=Periodlist;
kernels=kernstore;
kernelrads=rad;
pixlon =-117;

pixlat =42.5000;
USE_ALLUSANTData=1;
[periodlist,SR17PhVelList,measuredPhVelList,dcoverc] = Getdcoverc(pixlon,pixlat,USE_ALLUSANTData,Periodlist);
dcoverc=dcoverc';

layeredges = fliplr([6371:-5:6221]).*1000; 

dampinglist = [0.00000001 0.000000005 0.00000002];
dampinglist = [10^-6 10^-7 10^-8 ];
[G,radcenters] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);
dvsh=zeros(size(radcenters));
figure(1)
subplot(1,2,1)
pltlist(1).model = plot(dvsh,radcenters./1000,'linewidth',2,'color','k');
subplot(1,2,2)
pltlist(1).data = plot(periods,dcoverc,'linewidth',2,'color','k');

%%%% THIS IS ACCURATE. 
plotlist = [ pltlist(1).model];
plotlistdat= [ pltlist(1).data];
smoothingweight=0.1;

figure()
fcount=1;
for factor = dampinglist
    fcount=fcount+1;

%%%%
[Gaug,daug] = AddSmoothnessConstraint_GMatrix(G,radcenters,dcoverc,smoothingweight)

m= inv(G'*G+factor*eye(size(G'*G)))*G'*dcoverc;
m= inv(Gaug'*Gaug)*Gaug'*daug;

[Rads2Plot,VelocityVals2Plot] = Get_Layered_Model_For_Plotting(m,layeredges)
figure(1)
subplot(1,2,1)
hold on
pltlist(fcount).model = plot(VelocityVals2Plot,Rads2Plot./1000,'linewidth',2)
xlabel('dvsh/vsh (%)')
ylabel('radius (km)')
set(gca,'fontsize',16)
legend('Starting','Best fit Model')

subplot(1,2,2)
hold on
pltlist(fcount).data=plot(periods,G*m,'linewidth',2,'linestyle','--','linewidth',2)
xlabel('Period (s)')
ylabel('dc/c')
set(gca,'fontsize',16)
legend('Observed','Predicted')

legarraymodel{1} = 'Starting Model';
legarraymodel{fcount} = ['Damping \epsilon = ' num2str(factor)];

plotlist = [plotlist pltlist(fcount).model];
plotlistdat= [plotlistdat pltlist(fcount).data];

end
subplot(1,2,1)

legend(plotlist,legarraymodel)

subplot(1,2,2)

legend(plotlistdat,legarraymodel)

set(gcf,'position',[-93 474 1477 378])
