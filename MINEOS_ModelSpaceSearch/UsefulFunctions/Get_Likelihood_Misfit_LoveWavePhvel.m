function [New_Likelihood,New_MisfitSm,PredictedPhvel,FM_Periods,FM_Phvel] = Get_Likelihood_Misfit_LoveWavePhvel(Periods,PhVelMeasurements,depths,vsh)
% Predicts phase velos at the periods of interest, calculates lkelihood
[FM_Periods,FM_Phvel,ncard] = GetPredPhVel(depths,vsh);
DataCovariance = 0.2.*ones(size(PhVelMeasurements));
[uniqueperiods,dxdx] = unique(FM_Periods);
InterpedPhvels = interp1(uniqueperiods,FM_Phvel(dxdx),Periods);
New_MisfitSm = sum((InterpedPhvels-PhVelMeasurements).*DataCovariance.*(InterpedPhvels-PhVelMeasurements));
New_Likelihood = exp(-0.5*New_MisfitSm)

PredictedPhvel=InterpedPhvels;
end