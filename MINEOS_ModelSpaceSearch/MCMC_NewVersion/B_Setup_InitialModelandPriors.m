%% B: Setup the MCMC Parameterization and starting model
%% and the proposal distributions
%% begin the process. 

% First define the depth range
Model_Depths = [0:10:80];
premcard=read_model_card('Card_Files/prem_35.card');
% depth is in km
depths_native = premcard.z;
tmpdepths = depths_native;

for klm = 1:length(tmpdepths)-1
currdepth = tmpdepths(klm+1);
if currdepth == tmpdepths(klm)
    disp('adjust')
    tmpdepths(klm) = tmpdepths(klm)+0.001;
end
end

Dcounter=0;
% For every depth define a prior distribution (using PREM?)
for currDepth = Model_Depths
  Dcounter=Dcounter+1
 premvsh(Dcounter) = interp1(tmpdepths,premcard.vsh,currDepth);
% disp(Dcounter);
  Sample_Distribution(Dcounter,:) = [premvsh(Dcounter)-2500:10:premvsh(Dcounter)+2500];
  
end

%% Setup the Starting Model Here;
StartingModel=premvsh;
CurrentModel = StartingModel;

%% Get the initial likelihood
[New_Likelihood,New_MisfitSm,StartingModelPhvel]  = ...
    Get_Likelihood_Misfit_LoveWavePhvel(Periods2Use,Data2Match,Model_Depths,StartingModel);
Initial_Likelihood = New_Likelihood;
Current_Likelihood = Initial_Likelihood;

%% Set up Variables to store the proposal values
NumIter = 500000;
StepSize = 1500;
Acceptance_Counter=0;
ChainId = round(abs(5678*rand));
 rng(ChainId)
 AcceptanceRadeModifier =1;