% 
% test ice shell grp vel calcs

periodlist=[1:0.1:150];
maxN=10;
iceshellthicknesskm=10;
[GrpVels,PhVels,Periods,Nlist] = Get_GrpVels_IceShell(periodlist,maxN,iceshellthicknesskm);
scatter(Periods,GrpVels,50,Nlist,'filled')
