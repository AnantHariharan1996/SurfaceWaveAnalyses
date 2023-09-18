function [GrpVels,PhVels,Periods,Nlist] = Get_PhaseGrpVels_IceShell(periodlist,maxN,iceshellthicknesskm)
freqs = 1./periodlist;
Vs_ICe=2;
GrpVels=[];
PhVels=[];
Periods=[];
Nlist=[];
tmpN =[0:1:maxN]; 
for ijk = 1:length(tmpN)
    N=tmpN(ijk);
    term = (N.*Vs_ICe./(2.*freqs.*iceshellthicknesskm));
   denominator= sqrt(1-term.^2);
    C = Vs_ICe./(denominator);
    U = Vs_ICe.*denominator;
    PhVels=[PhVels; C'];
    GrpVels = [GrpVels; U'];
    Periods=[Periods; periodlist'];
    Nlist=[Nlist; N*ones(size(U))'];
    
end


end