function [Vp,Rho] = Predict_VpRho_Brochers(Vs)
% Brochers 2005 relations.
% eqn. 1,2 in Shen and Ritzwoller2016

Vp = 0.941 + 2.095.*Vs - 0.821.*Vs.^2 + 0.268.*Vs.^3 - 0.0251.*Vs.^4;
Rho = 1.227 + 1.53.*Vs - 0.837.*Vs.^2 + 0.207.*Vs.^3 - 0.0166.*Vs.^4;

% it's obviously not linear, but it's a smoothly varying scaling with no
% inflections or anything sketchy in the middle, as long as you stick to
% the domain used in the Brochers' study! 
% to generate a lookup table for derivative and Vs, you can use code below
% Vs = [2.9:0.001:5.25];
% [Vp,Rho] = Predict_VpRho_Brochers(Vs);
% Vplist= [5:0.001:9];
% Y = diff(f)/h; 
% Vsreglist = interp1(Vp,Vs,Vplist)



end