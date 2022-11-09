function [A_xt] = makegaussianwavepacket(x,tlist,kc,vg,vp,tau,sigmax,x_0)
% Amplitude of a gaussian wavepacket varying over time, defined
% as timelist 
% positionx x

 [sigma_t] = GetTimeDependentWidth(sigmax,tau,tlist);
 [phase] = PhaseofGaussianWavepacket(x,tlist,kc,vg,vp,tau,sigmax);
 term1 = -0.5.*(((x-(x_0+vg.*tlist))./sigma_t).^2);
 sinusoid = exp(i.*phase);
  gaussian = exp(term1);
  A_xt=gaussian.*sinusoid;

end