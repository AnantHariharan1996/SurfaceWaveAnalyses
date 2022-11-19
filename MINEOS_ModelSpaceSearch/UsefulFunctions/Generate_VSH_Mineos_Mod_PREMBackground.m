function [ncard,premcard] = Generate_VSH_Mineos_Mod_PREMBackground(depths,vsh)
% This function uses PREM as a background model, and writes a .card file
% where the only thing different are the vsh values at the gridpoints
% defined in the 'depths' vector. Assumes starting from zero
% vsh is in m/s
mindepth = min(depths);
maxdepth = max(depths);


% Load the PREM model

card=read_model_card('Card_Files/prem_35.card');
premcard=card;
% depth is in km
depths_native = card.z;
tmpdepths = depths_native;

for klm = 1:length(tmpdepths)-1
currdepth = tmpdepths(klm+1);
if currdepth == tmpdepths(klm)
%     disp('adjust')
    tmpdepths(klm) = tmpdepths(klm)+0.001;
end
end


%% 1) Interpolate the original model at these depths
% rho 
rho_interped = interp1(tmpdepths,card.rho,depths );
% vpv 
vpv_interped = interp1(tmpdepths,card.vpv,depths);
% vsv 
vsv_interped = interp1(tmpdepths,card.vsv,depths);
% qkap 
qkap_interped = interp1(tmpdepths,card.qkap,depths);
% qmu 
qmu_interped = interp1(tmpdepths,card.qmu,depths);
% vph 
vph_interped = interp1(tmpdepths,card.vph,depths);
% vsh 
vsh_interped = interp1(tmpdepths,card.vsh,depths);
% eta
eta_interped = interp1(tmpdepths,card.eta,depths);


%% 2) Replace all those depths with the new information 
idx = find(depths_native >= mindepth & depths_native <= maxdepth);

card.z(idx) =[];
card.z = [card.z; fliplr(depths)'];
card.rho(idx) =[];
card.rho = [card.rho; fliplr(rho_interped)'];

card.vpv(idx) =[];
card.vpv = [card.vpv; fliplr(vpv_interped)'];

card.vph(idx) =[];
card.vph = [card.vph; fliplr(vph_interped)'];

card.vsv(idx) =[];
card.vsv = [card.vsv; fliplr(vsv_interped)'];

card.vsh(idx) =[];
card.vsh = [card.vsh; fliplr(vsh)'];

card.eta(idx) =[];
card.eta = [card.eta; ((fliplr(vsh)./fliplr(vsv_interped)).^2)'];
fixdx = find(card.eta == Inf);
card.eta(fixdx) = 1;
card.qmu(idx) =[];
card.qmu = [card.qmu; fliplr(qmu_interped)'];

card.qkap(idx) =[];
card.qkap = [card.qkap; fliplr(qkap_interped)'];

card.rad(idx) =[];
%card.rad = [card.rad; 1000*(6371-fliplr(qkap_interped))'];
card.rad = 1000*(6371-card.z) ;
ncard=card;



end