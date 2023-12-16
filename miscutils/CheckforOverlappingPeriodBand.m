function [ overlapYN] =CheckforOverlappingPeriodBand(tlo1,thi1,tlo2,thi2)
% if output is 0 no overlap. if its 1 
% then there is an overlap.
% check if two period bands overlap
% note that there is no overlap if..
% thi1 < tlo2 OR if thi2 < tlo1
if (thi1 < tlo2) || (thi2 < tlo1)
overlapYN = 0;
else
overlapYN = 1;
end
end