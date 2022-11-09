function [GrpTime] = NOFILT_Get_Group_Arrival_Time(t,u)
% Measure group arrival time by fitting an envelope to a wavepacket?
% Pretty basic. 
 
[YUPPER,YLOWER] = envelope(u);
[maxmal,maxdx] = max(YUPPER);
GrpTime = t(maxdx);
end