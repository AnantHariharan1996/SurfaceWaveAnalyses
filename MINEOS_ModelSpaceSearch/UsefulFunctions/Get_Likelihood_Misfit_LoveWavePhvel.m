function [New_Likelihood,New_MisfitSm,PredictedPhvel] = Get_Likelihood_Misfit_LoveWavePhvel(Periods,PhVelMeasurements,depths,vsh)
% Predicts phase velos at the periods of interest, calculates lkelihood
[FM_Periods,FM_Phvel,ncard] = GetPredPhVel(depths,vsh);
DataCovariance = ones(size(PhVelMeasurements));
InterpedPhvels = interp1(FM_Periods,FM_Phvel,Periods);
New_MisfitSm = sum((InterpedPhvels-PhVelMeasurements).*DataCovariance.*(InterpedPhvels-PhVelMeasurements));
New_Likelihood = exp(-0.5*New_MisfitSm)

PredictedPhvel=InterpedPhvels;
end