function [sigma_t] = GetTimeDependentWidth(sigmax,tau,t)
% time is a vector of all times. 
% assumes a 'quadratic' dispersion relation- i.e. first and second
% derivative are defined, first derivative is grp vel and second derivative
% is tau. 
%sigma_t = sigmax*sqrt(1+(tau^2).*(t.^2)/(sigmax^4))
sigma_t = sigmax*sqrt(1+(tau^2).*(t.^2)/(sigmax^4));
end