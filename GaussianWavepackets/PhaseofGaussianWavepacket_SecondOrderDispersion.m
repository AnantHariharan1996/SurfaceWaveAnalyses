function [phase] = PhaseofGaussianWavepacket(x,tlist,kc,vg,vp,tau,sigmax)
% time is a vector of all times. x is a scalar- current position of
% receiver.
% assumes a 'quadratic' dispersion relation- i.e. first and second
% derivative are defined, first derivative is grp vel and second derivative
% is tau. 
phase=kc*x-kc.*tlist*(vg-vp)-(tlist.*tau)/( (tlist.^2)*(tau)^2 + sigmax^2);
end