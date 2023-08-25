function [G,radcenters] = Get_GMatrix_LayeredParam(periods,kernels,kernelrads,layeredges)
% generate G matrix for a layered model. 
% assuming Love wave phase velocities are the datum.
% Assuming vsv and rho are perfectly known. 
% No other damping in this matrix right now, but can add this later.
% This is just the sensitivity for Vsh to Love wave phvels. 
% Other functions will do other things to this matrix prior to inversion 
% but theoretically you could just do inv(GTG)*Gtd to get a solution
%
% layercenters is a vector of edges for each layer. That is, the number of
% layers is length(layercenters)-1
% layeredges is in radius space and in meters, and increases
% kernels is a matrix of kernels of dimension
% length(kernelrads)xlength(periods)

% first do the fix to adjust rads to ease with interps
for ijk = 1:length(kernelrads)-1
if kernelrads(ijk+1) == kernelrads(ijk)
kernelrads(ijk+1)=kernelrads(ijk+1)+0.001;
end
end

% get the integrated values of 
% the sensitivity kernels over every depth interval




for ijk = 1:length(periods)
currperiod= periods(ijk);
currkernel = kernels(ijk,:);

for klm = 1:length(layeredges)-1
currbotedge= layeredges(klm);
currtopedge = layeredges(klm+1);
radcenters(klm) = (currtopedge+currbotedge)/2;
values2eval = [currbotedge:1:currtopedge];
interpedkernel = interp1(kernelrads,currkernel,values2eval);
% now do the integral.
integrated_kernel = trapz(values2eval,interpedkernel);
G(ijk,klm) = integrated_kernel;
end

end

end