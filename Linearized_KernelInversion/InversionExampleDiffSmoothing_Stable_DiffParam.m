% Generate G Matrix Example
clear; close all; clc;
ReadKernels_Example
periods=Periodlist;
kernels=kernstore;
kernelrads=rad;
smoothinglist = fliplr([1 10^-1 10^-2 10^-3 10^-4 10^-5 10^-6 10^-7]);
LayerThickList = [1 5 10 20];
cmapp=turbo(length(smoothinglist)+1)

% generate dvsh perturbation and predict synthetic data
layeredges = [6000:1:6371].*1000; 
[G,radcentersorig] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);
dvsh = zeros(size(radcentersorig))';
%idx = find(radcentersorig >= 6341.5*1000 & radcentersorig < 6361.5*1000);
%idx = find(radcentersorig < 6344.5*1000);

% idx = find(radcentersorig >= 6224.5*1000 & radcentersorig < 6264.5*1000);
% dvsh(idx) = 0.01;

%dvsh = 0.01.*sind(0.005.*radcentersorig)';
%dvsh = 0.01.*normpdf(radcentersorig,6351000,10000)';
dvsh = 250.*normpdf(radcentersorig,6361000,10000)';

% predict dc/c
dcoverc = G*dvsh;

%%%%% Now do inversion for a bunch of layer thicknesses
thickcount=0;
for Thick = LayerThickList
thickcount=thickcount+1;

layeredges = fliplr([6371:-Thick:6000]).*1000; 
[G,radcenters] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);


figure(1)
subplot(2,length(LayerThickList),thickcount)
pltlist(1).model = plot(dvsh,radcentersorig./1000,'linewidth',2,'color','k');
subplot(2,length(LayerThickList),thickcount+length(LayerThickList))
pltlist(1).data = plot(periods,dcoverc,'linewidth',2,'color','k');

%%%% THIS IS ACCURATE. 
plotlist = [ pltlist(1).model];
plotlistdat= [ pltlist(1).data];
smoothingweight=0.00000001;

fcount=1;
for factor = smoothinglist
    fcount=fcount+1;

[Gaug,daug] = AddSmoothnessConstraint_GMatrix(G,radcenters,dcoverc,factor);



[Gaug,daug] = DampBottoms2StartingModel_Gmatrix(Gaug,radcenters,daug,0,6371-200);

%      figure(100)
%  subplot(1,2,1)
%  imagesc(Gaug)
%   subplot(1,2,2)
%  imagesc(Gaug)


%%%%
m= inv(Gaug'*Gaug)*Gaug'*daug;


[Rads2Plot,VelocityVals2Plot] = Get_Layered_Model_For_Plotting(m,layeredges)
figure(1)
subplot(2,length(LayerThickList),thickcount)
hold on
pltlist(fcount).model = plot(VelocityVals2Plot,Rads2Plot./1000,'linewidth',2,'color',cmapp(fcount,:))
xlabel('dvsh/vsh')
ylabel('radius (km)')
set(gca,'fontsize',16)
%legend('True Model','Best fit Model')
title(['Layer Thickness: ' num2str(Thick) 'km'])
ylim([min(layeredges) max(layeredges)]./1000)
subplot(2,length(LayerThickList),thickcount+length(LayerThickList))
hold on

pltlist(fcount).data=plot(periods,G*m,'linewidth',2,'linestyle','--','linewidth',2,'color',cmapp(fcount,:))
ylim([min(dcoverc) max(dcoverc)])
xlabel('Period (s)')
ylabel('dc/c')
set(gca,'fontsize',16)
%legend('Observed','Predicted')

legarraymodel{1} = 'True Model';
legarraymodel{fcount} = ['Smoothing \epsilon = ' num2str(factor)];

plotlist = [plotlist pltlist(fcount).model];
plotlistdat= [plotlistdat pltlist(fcount).data];

end
% subplot(1,2,1)
% 
% legend(plotlist,legarraymodel)
% 
% subplot(1,2,2)
% 
% legend(plotlistdat,legarraymodel)
% 
% %set(gcf,'position',[-93 474 1477 378])


end
subplot(2,length(LayerThickList),thickcount)
 legend(plotlist,legarraymodel)