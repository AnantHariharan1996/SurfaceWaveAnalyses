%% A GridSearch: Setup the synthetic dataset
%% Store the synthetic dataset in Data2Match and Periods2Use
% 
clear; clc; close all;
%SyntheticPeriods = [5 6 8 10 12 15 20 25 30 35 40 45 50 60 75];
SyntheticPeriods = [10 12 15 20 25 30 35 40 45 50 60 75];

%% Load Dataset
% (In this case, -predict- a synthetic dataset)

depths = [0 10 20 30 40 50 60 70];
vsh = 1000.*[3.8 3.8 3.8 3.8 4.5 4.5 4.5 4.5 ];


[ncard,premcard] = Generate_VSH_Mineos_Mod_PREMBackground(depths,vsh)
write_MINEOS_mod(ncard,['Card_Files/SynthModel.card'])

mode=2; ParamFname='ParamFileSynth';
Ascname = 'Synth.asc';
Eigname = 'Synth.eig';
[ParamFname] = Write_Param_File(ParamFname,'SynthModel.card',...
    Ascname,Eigname,2,0);
[String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
[ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = Read_MINEOS_asc_File(['asc_Files/' Ascname]);
FMdx = find(nlist == 0);
FM_Ttim = tsecs(FMdx);
FM_phvel = phvel(FMdx);


%% Plotting below here
%%


figure(1)
subplot(1,2,1)
plot(ncard.vsh,ncard.z,'-ro','linewidth',2)
grid on; box on;
ylabel('Depth (km)')
xlabel('Vsh (m/s)')
ylim([0 300])
hold on
plot(premcard.vsh,premcard.z,'-b')
legend('True Model','PREM','location','southwest')
set(gca,'ydir','reverse','fontsize',16)

subplot(1,2,2)

%plot(SyntheticPeriods,synthdata_Noisy,'-ro')
%hold on
plot(FM_Ttim,FM_phvel,'-bo')
set(gca,'fontsize',16)
ylabel('Love wave Phase Velocity (km/s)')
xlabel('Period (s)')
%legend('Noise-free','noisy')

%%
[FM_Ttim,dx] = unique(FM_Ttim);
synthdata = interp1(FM_Ttim,FM_phvel(dx),SyntheticPeriods);
synthdata_Noisy = synthdata+synthdata.*(rand(size(synthdata))-0.5)./100;


Data2Match = synthdata;
Periods2Use = SyntheticPeriods;
TrueModel = ncard;
TrueModel_Depths = depths;
TrueModel_vsh = vsh;
% get prem phase velo. and overlay for sanity. 

mode=2; ParamFname='ParamFilePrem';
Ascname = 'Prem.asc';
Eigname = 'Prem.eig';
[ParamFname] = Write_Param_File(ParamFname,'prem_35.card',...
    Ascname,Eigname,2,0);
[String] = Run_Mineos(ParamFname,'minos_bran_moreknot');
[ModelMat,nlist,llist,phvel,wmhz,tsecs,grpvel,q,raylquo] = Read_MINEOS_asc_File(['asc_Files/' Ascname]);
FMdx = find(nlist == 0);
FM_Ttim = tsecs(FMdx);
FM_phvel = phvel(FMdx);
hold on
plot(FM_Ttim,FM_phvel,'-ko')
legend('Synth','PREM')