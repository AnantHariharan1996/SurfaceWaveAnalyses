%% MCMC Setup Parameters
% 
clear; clc; close all;
CleanWorkingFolder
LayerEdges = [50 100];
NLayers_Model = length(LayerEdges(:,1));
Vsh_Prior_Edges = [2000 6000];
Perturb_VeloList = 300;
StoreCounter=1;

card=read_model_card('Card_Files/prem_35.card');
StartingModel=card;
CurrentModel=StartingModel;
NumIter=400;

%% Load Dataset
% (In this case, -predict- a synthetic dataset)
card=read_model_card('Card_Files/prem_35.card');
depthdx = find(card.z>min(LayerEdges) & card.z<max(LayerEdges) );
card.vsh(depthdx) = 3000;
write_MINEOS_mod(card,['Card_Files/prem_35_LVZSynth.card'])

mode=2; ParamFname='ParamFile_noisydata';
Ascname = 'prem_35_LVZSynth.asc';
Eigname = 'prem_35_LVZSynth.eig';
[ParamFname] = Write_Param_File(ParamFname,'prem_35_LVZSynth.card',...
    Ascname,Eigname,2,1);
[String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
[ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = Read_MINEOS_asc_File(['asc_Files/' Ascname]);
FMdx = find(nlist == 0 & tsecs>30 & tsecs < 100);
FM_Ttim = tsecs(FMdx);
FM_phvel = phvel(FMdx);
NoisyData=FM_phvel+0.075.*(rand(1,length(FM_phvel))-0.5);
NoisyData_Periods = FM_Ttim;
figure(1)
plot(FM_Ttim,FM_phvel,'-bo','linewidth',2)
xlabel('Period (s)')
ylabel('Phase Velocity (km/s)')
hold on
plot(FM_Ttim,NoisyData,'-ro','linewidth',2)
grid on; box on;
set(gca,'fontsize',16,'fontweight','bold')
TrueModelCard = card;
%% Finished Loading Dataset


Data2Use_Period=NoisyData_Periods;
Data2Use_Phvel=NoisyData;
DataCovariance=1*ones(size(Data2Use_Phvel));

write_MINEOS_mod(StartingModel,['Card_Files/MCMCStartingModel.card'])
mode=2; ParamFname='ParamFile_StartingModel';
Ascname = 'StartingModel.asc';
Eigname = 'StartingModel.eig';
[ParamFname] = Write_Param_File(ParamFname,'MCMCStartingModel.card',...
    Ascname,Eigname,mode,1);
[String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
[ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = Read_MINEOS_asc_File(['asc_Files/' Ascname]);
FMdx = find(nlist == 0 & tsecs>25 & tsecs < 180);
FM_Ttim = tsecs(FMdx);
FM_phvel = phvel(FMdx);
InterpedPhvels = interp1(FM_Ttim,FM_phvel,Data2Use_Period);

% Get starting misfit and likelihood
Current_MisfitSm = sum((InterpedPhvels-Data2Use_Phvel).*DataCovariance.*(InterpedPhvels-Data2Use_Phvel));
Current_Likelihood = exp(-0.5*Current_MisfitSm);
Misfitlist(StoreCounter) =Current_MisfitSm;
Likelihoodlist(StoreCounter) =Current_Likelihood;

figure(1)
plot(Data2Use_Period,InterpedPhvels,'-ko','linewidth',2)


figure(12)
    plot(StartingModel.vsh,StartingModel.z,'linewidth',2)
    hold on
        plot(card.vsh,card.z,'linewidth',2)
set(gca,'fontsize',15,'fontweight','bold')
xlabel('Vsh')
ylim([0 200])
ylabel('Depth (km)')