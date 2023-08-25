

% Plot Model Resolution Matrices for Different Parameterizations

clear; close all; clc;
ReadKernels_Example
periods=Periodlist;
kernels=kernstore;
kernelrads=rad;
counter=0;
seplist =[1 ];% 2 5 7.5 10 20];
dampinglist = [10^-9 ]%10^-11 10^-13 10^-15 ];
dcoverc= zeros(size(periods));
    for factor = dampinglist 

for layersep = seplist
counter=counter+1;

layeredges = [6371:-layersep:6171].*1000; 
layeredges=fliplr(layeredges);
[G,radcenters] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);
[Gaug,daug] = AddSmoothnessConstraint_GMatrix(G,radcenters,dcoverc,factor);

figure(1)

subplot(length(dampinglist),length(seplist),counter)
%factor=1*10^-5;
GhighG = inv(Gaug'*Gaug)*Gaug'*Gaug;
imagesc(fliplr(flipud(GhighG')))
colormap(turbo)
colorbar
caxis([0 1])
title(['Layer Thickness: ' num2str(layersep) 'km,' ' \epsilon = ' num2str(factor)])
set(gca,'fontsize',11,'fontweight','bold') 

%% Set up labels: 
ticklist = [1:ceil(length(radcenters)/10):length(radcenters)];
xticks(ticklist)
yticks(ticklist)
for jjkkll = 1:length(ticklist)
    labelist{jjkkll} = [num2str(radcenters(ticklist(jjkkll))/1000) ' km'];
end

xlabel('layer number')
clear labelist

    end




end