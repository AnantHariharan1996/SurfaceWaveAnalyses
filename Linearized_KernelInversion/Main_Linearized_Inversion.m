%% Linearized Inversion at a Single Pixel

clear; clc; close all;
Periodlist = [12    15    20   ...
    25    30    35    40    45  50    60    75];
USE_ALLUSANTData=1;
LayerDeps=[0:5:200];
PixLon=-100;
PixLat=32;
Thick=5;
factor=1e-3;
layeredges = fliplr([6371:-Thick:6171]).*1000; 


%% Step 1: Get dc/c
load('ModelInfo.mat')
latlist = ModelInfo(1).latlist;
lonlist = ModelInfo(1).lonlist;
% 1a) Get measured phvels
[periodlist,PhVelList] = Get_USArray_Phvel(PixLon,PixLat,USE_ALLUSANTData,Periodlist)
% 1b) Get Predicted/Starting phvels
distlist=distance(PixLat,PixLon,latlist,lonlist);
[mindist,mindx]=min(distlist);
currperiod = ModelInfo(mindx).tsecs;
currphvel = ModelInfo(mindx).phvel;
predictedphvel =  interp1(currperiod,currphvel,Periodlist);
dcoverc=(PhVelList-predictedphvel)./predictedphvel;
dcoverc=dcoverc';

%% Step 2: Construct G Matrix
% 2a) Get kernels for the G matrix
kernmat=ModelInfo(mindx).Kernels;
kernelrads=ModelInfo(mindx).rad;
for ijk=1:length(Periodlist)
  idx=find(Periodlist(ijk)==ModelInfo(mindx).periods);
  if length(idx) > 0
    currkern=kernmat(idx,:);
    kernstore(ijk,:) = currkern;
  end
end
[G,radcentersorig] = Get_GMatrix_LayeredParam(Periodlist,kernstore,kernelrads,...
    layeredges);
[Gaug,daug] = AddSmoothnessConstraint_GMatrix(G,radcentersorig,dcoverc,factor);

%% Step 3: Do Inversion
m= inv(Gaug'*Gaug)*Gaug'*daug;
dpred=G*m;

%% Step 4: Calculate vsh
% and also radial anisotropy. 