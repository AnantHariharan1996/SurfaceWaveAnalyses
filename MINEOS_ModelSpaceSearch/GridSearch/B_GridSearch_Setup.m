%% B: Setup the MCMC Parameterization and starting model
%% and the proposal distributions
%% begin the process. 

% First define the depth range
Model_Depths = [0:10:70];
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

GridSearchRanges(1).Vs2Perturb = [3800];
GridSearchRanges(2).Vs2Perturb = [3800-200:200:3800+400];
GridSearchRanges(3).Vs2Perturb = [3800-200:200:3800+400];
GridSearchRanges(4).Vs2Perturb = [3800-200:200:3800+400];
GridSearchRanges(5).Vs2Perturb = [4500-400:200:4500+200];
GridSearchRanges(6).Vs2Perturb = [4500-400:200:4500+200];
GridSearchRanges(7).Vs2Perturb = [4500-400:200:4500+200];
GridSearchRanges(8).Vs2Perturb = [4500-400:200:4500+200];

% Ad hoc code above to define the parameter space





%%%%%
% Make a plot of the range you are sampling here 
for ijk = 1:length(GridSearchRanges)
figure(1)
subplot(1,2,1)
scatter(GridSearchRanges(ijk).Vs2Perturb,Model_Depths(ijk)*ones(size(GridSearchRanges(ijk).Vs2Perturb)) )

hold on
end
