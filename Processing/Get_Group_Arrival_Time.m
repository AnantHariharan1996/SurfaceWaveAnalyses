function [GrpTime,YUPPER] = Get_Group_Arrival_Time(t,u,highperiod,lowperiod)
% Measure group arrival time by fitting an envelope to a wavepacket?
% First bandpass-filters the wavepacket with bounds according to highperiod
% and lowperiod. 
% Pretty basic. 

dt = t(2)-t(1);
vf1=bandpassSeis(u',dt,1./highperiod,1./lowperiod);
[YUPPER,YLOWER] = envelope(vf1);
[maxmal,maxdx] = max(YUPPER);
GrpTime = t(maxdx);
end