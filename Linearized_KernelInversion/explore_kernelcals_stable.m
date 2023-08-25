% Generate G Matrix Example
clear; close all; clc;
ReadKernels_Example
periods=Periodlist;
kernels=kernstore;
kernelrads=rad;
layeredges = [6000:0.05:6371].*1000;

[G,radcenters] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,...
    layeredges);

% generate dvsh perturbation

dvsh = zeros(size(radcenters));
idx = find(radcenters >= 6294.5*1000 & radcenters <= 6310.5*1000);

dvsh(idx) = 0.01;

% predict dc/c
dcoverc = G*dvsh';

figure()
plot(periods,dcoverc,'linewidth',2,'color','k')

%%%% THIS IS ACCURATE. 

figure()
imagesc(G)