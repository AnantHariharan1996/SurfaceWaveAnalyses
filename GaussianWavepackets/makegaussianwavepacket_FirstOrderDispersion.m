function [A_xt] = makegaussianwavepacket_FirstOrderDispersion(A0,sigma,grpvel,tlist,period,X,phvel)
% Amplitude of a gaussian wavepacket varying over time
% A0 amplitude of wavepacket
% sigma width of envelope
% grpvel envelope speed
% tlist time
% period period of carrier
% X epicentral distance
% phvel phvel of carrier

% Carrier 
omega = 2*pi/period;
k = omega/phvel;
Carrier = exp(-1.*i.*(omega.*tlist - k*X));

% envelope
tg = X/grpvel;
Envelope = A0.*exp(-1*((tlist-tg).^2)./(2*(sigma^2)));

% combine
A_xt = Envelope.*Carrier;



end