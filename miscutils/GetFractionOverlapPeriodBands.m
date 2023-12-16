function [fracoverlap] = GetFractionOverlapPeriodBands(tlo1,thi1,tlo2,thi2)

overlapYN = CheckforOverlappingPeriodBand(tlo1,thi1,tlo2,thi2)

if overlapYN == 1 

DynRange1 = thi1-tlo1; 
DynRange2 = thi2-tlo2;
% only care about larger of the two
Diff1 = thi1-tlo2; 
Diff2 = thi2-tlo1;
% one of the above is negative. dont
% want that 

fracoverlap = max([Diff1 Diff2])/...
max([DynRange1 DynRange2]);

elseif overlapYN == 0

fracoverlap=0;

else

error('the check for overlapping period bands failed.')

end 
end