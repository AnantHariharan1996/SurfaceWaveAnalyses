function [GrpVels,Periods,Nlist] = Get_GrpVels_IceShell(periodlist,maxN,iceshellthicknesskm)
% Doesn't seem to be working yet. 

freqs = 2*pi./periodlist;
Vs_ICe=2;
GrpVels=[];
Periods=[];
Nlist=[];
tmpN =[0:1:maxN]; 
for N = tmpN
    term = (N.*Vs_ICe./(2.*freqs.*iceshellthicknesskm));
   denominator= sqrt(1-term.^2);
    U = Vs_ICe./(denominator);
 

    GrpVels = [GrpVels; U'];
    Periods=[Periods; periodlist'];
    Nlist=[Nlist; N*ones(size(U))'];
    
end


end